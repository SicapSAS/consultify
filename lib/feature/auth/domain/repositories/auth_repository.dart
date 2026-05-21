


import 'package:consultify/feature/feature.dart';

abstract class AuthRepository {
  
  Future<User> login(String email, String password);

  Future<User> register(String email, String password, String name, String lastName);

  Future<User> checkAuthStatus(String accessToken);

  Future<User> refreshToken(String email, String password);
}