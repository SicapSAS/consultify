import 'package:dio/dio.dart';
import 'package:consultify/feature/feature.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  AuthRepositoryImpl({
    AuthDataSource? dataSource,
    Dio? dio,
  }) : dataSource = dataSource ?? 
      AuthDatasourcesImpl(dio: dio);

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String name, String lastName) {
    return dataSource.register(email, password, name, lastName);
  }

  @override
  Future<User> checkAuthStatus(String accessToken) {
    return dataSource.checkAuthStatus(accessToken);
  }

  @override
  Future<User> refreshToken(String email, String password) {
    return dataSource.refreshToken(email, password);
  }

}