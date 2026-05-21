import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  final storage = KeyValueStorageServiceImpl();
  final authRepository = AuthRepositoryImpl();
  Future<String?>? _refreshTokenFuture;

  Future<String?> refreshAccessToken() async {
    final email = await storage.getValue<String>('userEmail');
    final password = await storage.getValue<String>('userPassword');

    if (email == null ||
        password == null ||
        email.isEmpty ||
        password.isEmpty) {
      return null;
    }

    final user = await authRepository.refreshToken(email, password);
    await storage.setKeyValue('accessToken', user.accessToken);
    return user.accessToken;
  }

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        var token = await storage.getValue<String>('accessToken') ??
            await storage.getValue<String>('access_token');

        if (token != null && token.isNotEmpty) {
          if (TokenService.isTokenAboutToExpire(token, thresholdMinutes: 5)) {
            _refreshTokenFuture ??= () async {
              try {
                final refreshedToken = await refreshAccessToken();
                if (refreshedToken != null && refreshedToken.isNotEmpty) {
                  print('Token renovado automáticamente');
                }
                return refreshedToken;
              } catch (e) {
                print('Error al renovar token: $e');
                return null;
              } finally {
                _refreshTokenFuture = null;
              }
            }();

            final refreshedToken = await _refreshTokenFuture;
            if (refreshedToken != null && refreshedToken.isNotEmpty) {
              token = refreshedToken;
            }
          }

          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        // 401: intentar renovar el token y rehacer la petición antes de mapear
        if (error.response?.statusCode == 401) {
          try {
            _refreshTokenFuture ??= () async {
              try {
                return await refreshAccessToken();
              } finally {
                _refreshTokenFuture = null;
              }
            }();

            final refreshedToken = await _refreshTokenFuture;
            if (refreshedToken != null && refreshedToken.isNotEmpty) {
              final opts = error.requestOptions;
              opts.headers['Authorization'] = 'Bearer $refreshedToken';
              final response = await dio.fetch(opts);
              return handler.resolve(response);
            }
          } catch (e) {
            print('Error al renovar token en interceptor: $e');
          }
          // Si el refresh falló, cae al mapeo general abajo
        }

        // Mapa todos los DioException a CustomError con FailureKind/severity.
        // Así cada datasource recibe `e.error as CustomError` ya clasificado.
        final customError = DioErrorMapper.fromDioException(error);
        return handler.reject(
          DioException(
            requestOptions: error.requestOptions,
            response: error.response,
            type: error.type,
            error: customError,
            message: customError.message,
          ),
        );
      },
    ),
  );

  return dio;
});
