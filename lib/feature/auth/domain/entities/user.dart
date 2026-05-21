

class User {
  final String id;
  final String email;
  final String name;  
  //final String lastName;
  final String role;
  final String accessToken;
  /// ID de la clínica asociada (recepción, doctores). Null para SUPER_ADMIN.
  final String? clinicId;

  User({
    required this.id,
    required this.email,
    required this.name,
    //required this.lastName,
    required this.accessToken,
    required this.role,
    this.clinicId,
  });

  bool get hasClinic => clinicId != null && clinicId!.isNotEmpty;

  /*bool isAdmin() {
    return roles.contains('admin');
  }*/
}