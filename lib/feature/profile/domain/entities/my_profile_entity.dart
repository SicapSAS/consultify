class MyProfileEntity {
    final String id;
    final String name;
    final String email;
    final String role;
    final String roleLabel;
    final String specialty;
    final String professionalCardNumber;
    final String documentType;
    final String documentId;
    final bool isActive;
    final DateTime createdDate;
    final String createdTime;
    final String createdAtFormatted;
    final Clinic clinic;

    MyProfileEntity({
        required this.id,
        required this.name,
        required this.email,
        required this.role,
        required this.roleLabel,
        required this.specialty,
        required this.professionalCardNumber,
        required this.documentType,
        required this.documentId,
        required this.isActive,
        required this.createdDate,
        required this.createdTime,
        required this.createdAtFormatted,
        required this.clinic,
    });

}

class Clinic {
    final String id;
    final String name;
    final String phone;
    final bool isActive;

    Clinic({
        required this.id,
        required this.name,
        required this.phone,
        required this.isActive,
    });

}
