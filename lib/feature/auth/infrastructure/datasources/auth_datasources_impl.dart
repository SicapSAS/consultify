import 'package:dio/dio.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';


class AuthDatasourcesImpl implements AuthDataSource {

  final Dio dio;
  
  AuthDatasourcesImpl({
    Dio? dio,
  }) : dio = dio ?? Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<User> login(String email, String password) async {
    
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      
      return UserMapper.userJsonToEntity(response.data, email: email);
      
    } on DioException catch (e) {
      if ( e.response?.statusCode == 401) {
        throw CustomError(
          message: e.response?.data['message'] 
          ?? 'Credenciales incorrectas'
        );
      }
      if ( e.type== DioExceptionType.connectionTimeout) {
        throw CustomError(message: 'Ups!, no tienes conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String name, String lastName) {
    // TODO: implement register
    throw UnimplementedError();
  }

  
  @override
  Future<User> checkAuthStatus(String accessToken) async {
    try {
      // El interceptor en dioProvider ya agrega el token automáticamente,
      // pero lo mantenemos aquí por compatibilidad y para casos específicos
      final response = await dio.post(
        '/auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        )
      );
      // Pasar el accessToken al mapper porque /auth/me no lo devuelve en la respuesta
      final user = UserMapper.userJsonToEntity(response.data, accessToken: accessToken);
      return user;

    } on DioException catch (e) {
      // Error 401: Token inválido o expirado - hacer logout
      if ( e.response?.statusCode == 401) {
        throw CustomError(
          message: 'Token incorrecto'
        );
      }
      // Códigos 3xx (redirecciones): No son errores críticos, no hacer logout
      if ( e.response?.statusCode != null && 
           e.response!.statusCode! >= 300 && 
           e.response!.statusCode! < 400) {
        throw Exception('Error de redirección (${e.response!.statusCode}): ${e.message}');
      }
      // Timeouts: No hacer logout
      if ( e.type == DioExceptionType.connectionTimeout || 
           e.type == DioExceptionType.receiveTimeout ||
           e.type == DioExceptionType.sendTimeout) {
        throw Exception('Error de timeout: ${e.message}');
      }
      // Errores de conexión: No hacer logout
      if ( e.type == DioExceptionType.connectionError) {
        throw Exception('Error de conexión: ${e.message}');
      }
      // Para otros errores de Dio, lanzar como Exception genérica
      // para que no cause logout automático
      throw Exception('Error de red: ${e.message}');
    } catch (e) {
      // Si ya es CustomError, re-lanzarlo
      if (e is CustomError) rethrow;
      // Para otros errores, lanzar como Exception genérica
      throw Exception('Error desconocido: $e');
    }
  }

  @override
  Future<User> refreshToken(String email, String password) async {
    // Reutilizar el método de login para renovar el token
    return await login(email, password);
  }
  
  
}