import 'package:dio/dio.dart';
import 'package:consultify/feature/feature.dart';

class DioErrorMapper {
  DioErrorMapper._();

  /// Convierte un [DioException] en un [CustomError] con tipo y severidad.
  ///
  /// Si el error ya fue mapeado por el interceptor (`e.error is CustomError`),
  /// lo devuelve directamente sin re-procesar.
  ///
  /// [mensajeFallback] se usa cuando el servidor no incluye un mensaje legible
  /// y el error es un 4xx. Para timeouts y conexión se ignora.
  static CustomError fromDioException(
    DioException e, {
    String? mensajeFallback,
  }) {
    if (e.error is CustomError) return e.error as CustomError;

    switch (e.type) {
      case DioExceptionType.connectionError:
        return const CustomError(
          message: 'Sin conexión a internet. Verifica tu red e intenta de nuevo.',
          kind: FailureKind.sinConexion,
          severity: FailureSeverity.error,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const CustomError(
          message: 'La conexión tardó demasiado. Verifica tu red e intenta de nuevo.',
          kind: FailureKind.timeout,
          severity: FailureSeverity.advertencia,
        );
      default:
        break;
    }

    final statusCode = e.response?.statusCode;
    final serverMessage = _extractServerMessage(e);

    if (statusCode == 401) {
      return CustomError(
        message: serverMessage ?? 'Sesión expirada. Inicia sesión de nuevo.',
        errorCode: 401,
        kind: FailureKind.sesionInvalida,
        severity: FailureSeverity.error,
      );
    }

    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return CustomError(
        message: serverMessage ?? mensajeFallback ?? 'La solicitud no pudo completarse.',
        errorCode: statusCode,
        kind: FailureKind.servidor,
        severity: FailureSeverity.error,
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return CustomError(
        message: serverMessage ??
            mensajeFallback ??
            'El servicio no está disponible. Intenta más tarde.',
        errorCode: statusCode,
        kind: FailureKind.servidor,
        severity: FailureSeverity.error,
      );
    }

    return CustomError(
      message: mensajeFallback ?? 'Ocurrió un error inesperado.',
      kind: FailureKind.desconocido,
      severity: FailureSeverity.error,
    );
  }

  static String? _extractServerMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      for (final key in ['message', 'error', 'mensaje']) {
        final value = data[key];
        if (value is String && value.isNotEmpty) return value;
      }
    }
    return null;
  }
}
