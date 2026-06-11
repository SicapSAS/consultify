class DoctorUpdate {
  final String name;
  final String email;
  final String specialty;
  final String professionalCardNumber;
  final String documentType;
  final String documentId;

  /// Opcional. Si se deja en blanco, no se actualiza la contraseña.
  final String password;

  DoctorUpdate({
    required this.name,
    required this.email,
    required this.specialty,
    required this.professionalCardNumber,
    required this.documentType,
    required this.documentId,
    this.password = '',
  });
}
