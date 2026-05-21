import 'dart:convert';

/// Servicio para manejar la decodificación y verificación de tokens JWT
class TokenService {
  /// Decodifica un token JWT y retorna el payload
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      // Decodificar el payload (segunda parte del JWT)
      final payload = parts[1];
      // Agregar padding si es necesario para base64
      final normalizedPayload = _normalizeBase64(payload);
      final decoded = utf8.decode(base64Url.decode(normalizedPayload));
      return json.decode(decoded) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Normaliza el string base64 agregando padding si es necesario
  static String _normalizeBase64(String base64) {
    final remainder = base64.length % 4;
    if (remainder != 0) {
      return base64 + '=' * (4 - remainder);
    }
    return base64;
  }

  /// Obtiene la fecha de expiración del token
  static DateTime? getTokenExpiration(String token) {
    final payload = decodeToken(token);
    if (payload == null) return null;

    final exp = payload['exp'];
    if (exp == null) return null;

    // El campo 'exp' está en segundos desde epoch
    return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  }

  /// Verifica si el token está a punto de vencer
  /// [thresholdMinutes] es el tiempo en minutos antes de la expiración para considerar renovar
  static bool isTokenAboutToExpire(String token, {int thresholdMinutes = 5}) {
    final expiration = getTokenExpiration(token);
    if (expiration == null) return true; // Si no se puede decodificar, considerar expirado

    final now = DateTime.now();
    final timeUntilExpiration = expiration.difference(now);
    
    // Si ya expiró o está a punto de expirar (dentro del threshold)
    return timeUntilExpiration.inMinutes <= thresholdMinutes;
  }

  /// Verifica si el token ya expiró
  static bool isTokenExpired(String token) {
    final expiration = getTokenExpiration(token);
    if (expiration == null) return true;

    return DateTime.now().isAfter(expiration);
  }
}
