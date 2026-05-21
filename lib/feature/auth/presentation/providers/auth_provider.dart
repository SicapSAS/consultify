import 'package:flutter_riverpod/legacy.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  // casos de uso: 1. login, 2. register, 3. checkAuthStatus
  // Usar el dioProvider que tiene el interceptor configurado
  final dio = ref.watch(dioProvider);
  final authRepository = AuthRepositoryImpl(dio: dio);
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  bool _isCheckingAuth = false;
  
  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed( Duration(milliseconds: 500));

    try {

      final user = await authRepository.login(email, password);
      await _setLoggedUser(user, password: password);

    } on CustomError catch (e) {
      logout(e.message);
    }  catch (e) {
      logout('Ups!, Error no controlado');
    }

  }
  void registerUser(String email, String password, String name, String lastName) async {

  }
  void checkAuthStatus() async {
    // Prevenir múltiples llamadas concurrentes
    if (_isCheckingAuth) {
      return;
    }
    
    _isCheckingAuth = true;
    
    try {
      final accessToken = await keyValueStorageService.getValue<String>('accessToken');
      
      if (accessToken == null || accessToken.isEmpty) {
        _isCheckingAuth = false;
        return logout();
      }
      
      try {
        final user = await authRepository.checkAuthStatus(accessToken);
        // No guardar password en checkAuthStatus ya que no lo tenemos
        await _setLoggedUser(user);
      } on CustomError catch (e) {
        // Solo hacer logout si es un error de autenticación (401)
        print('Error de autenticación: ${e.message}');
        logout(e.message);
      } catch (e) {
        // Para otros errores (red, timeout, redirecciones, etc.), no hacer logout
        // Si hay un token guardado, intentar restaurar el estado autenticado
        // usando el email guardado para evitar deslogueos por errores temporales
        
        if (!mounted) {
          return;
        }
        
        // Si hay token guardado, intentar restaurar el estado autenticado
        if (accessToken.isNotEmpty) {
          // Intentar recuperar el email guardado para crear un usuario temporal
          final savedEmail = await keyValueStorageService.getValue<String>('userEmail');
          final savedRole = await keyValueStorageService.getValue<String>('userRole');
          
          if (savedEmail != null && savedEmail.isNotEmpty) {
            // Crear un usuario temporal con el token y email guardados
            final tempUser = User(
              id: '0', // ID temporal, se actualizará en la próxima verificación exitosa
              email: savedEmail,
              accessToken: accessToken,
              name: '',
              role: savedRole ?? '',
            );
            
            if (!mounted) {
              return;
            }
            
            state = state.copyWith(
              user: tempUser,
              authStatus: AuthStatus.authenticated,
              errorMessage: '',
            );
          }
          // Si no hay email guardado pero hay token, mantener el estado checking
          // NO cambiar a notAuthenticated para evitar deslogueo por errores temporales
        } else {
          // Solo cambiar a notAuthenticated si realmente no hay token
          if (!mounted) return;
          if (state.authStatus == AuthStatus.checking) {
            state = state.copyWith(
              authStatus: AuthStatus.notAuthenticated,
              errorMessage: '',
            );
          }
        }
      }
    } finally {
      _isCheckingAuth = false;
    }
  }

  Future<void> _setLoggedUser(User user, {String? password}) async {
    // Guardar el token y el email del usuario
    await keyValueStorageService.setKeyValue('accessToken', user.accessToken);
    await keyValueStorageService.setKeyValue('userEmail', user.email);
    await keyValueStorageService.setKeyValue('userRole', user.role);
    
    // Guardar el password de forma temporal para renovación de token
    // Nota: En producción, considera usar flutter_secure_storage para mayor seguridad
    if (password != null) {
      await keyValueStorageService.setKeyValue('userPassword', password);
    }

    if (!mounted) {
      return;
    }

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    // Limpiar el token, email y password guardados
    await keyValueStorageService.removeKey('accessToken');
    await keyValueStorageService.removeKey('userEmail');
    await keyValueStorageService.removeKey('userRole');
    await keyValueStorageService.removeKey('userPassword');

    if (!mounted) {
      return;
    }

    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      errorMessage: errorMessage,
    );
  }
  
}

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}


class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  String toString() {
    return '''
    AuthState:
    authStatus: $authStatus
    user: $user
    errorMessage: $errorMessage
    ''';
  }
}