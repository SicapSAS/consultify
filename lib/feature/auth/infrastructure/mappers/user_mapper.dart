import 'package:consultify/feature/feature.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json, {String? email, String? accessToken}) {
    final originalData = json['data']?['original'] ?? json;

    final token = accessToken ??
        originalData['token'] as String? ??
        originalData['access_token'] as String? ??
        '';

    final roleData = originalData['role'] ??
        originalData['roles'] ??
        json['permisos'] ??
        '';

    final clinicId = originalData['clinicId']?.toString();

    return User(
      id: originalData['_id']?.toString() ??
          originalData['user_id']?.toString() ??
          '0',
      email: email ?? originalData['email']?.toString() ?? '',
      name: originalData['name']?.toString() ?? '',
      accessToken: token,
      role: roleData.toString().trim(), // <-- Forzar a String limpio sin espacios
      clinicId: clinicId != null && clinicId.isNotEmpty ? clinicId : null,
    );
  }
}