
enum FailureKind {
  sinConexion,
  timeout,
  servidor,
  sesionInvalida,
  desconocido,
}

enum FailureSeverity {
  error,
  advertencia,
  info,
}

class WrongCredentials implements Exception {}

class InvalidAccessToken implements Exception {}

class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  final String? message;
  final int? errorCode;
  final FailureKind kind;
  final FailureSeverity severity;

  const CustomError({
    this.message,
    this.errorCode,
    this.kind = FailureKind.desconocido,
    this.severity = FailureSeverity.error,
  });
}
