class DoctorsList {
    final int total;
    final List<Doctor> doctors;

    DoctorsList({
        required this.total,
        required this.doctors,
    });

}

class Doctor {
    final String id;
    final String clinicId;
    final String name;
    final String email;
    final String role;
    final String specialty;
    final bool isActive;
    final String documentType;
    final String documentId;
    final String professionalCardNumber;
    final String createdAtFormatted;

    Doctor({
        required this.id,
        required this.clinicId,
        required this.name,
        required this.email,
        required this.role,
        required this.specialty,
        required this.isActive,
        required this.documentType,
        required this.documentId,
        required this.professionalCardNumber,
        required this.createdAtFormatted,
    });

}
