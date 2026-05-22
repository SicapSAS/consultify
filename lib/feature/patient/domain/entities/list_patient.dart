class ListPatient {
    final int total;
    final List<Patient> patients;

    ListPatient({
        required this.total,
        required this.patients,
    });

}

class Patient {
    final String id;
    final String clinicId;
    final String name;
    final String documentId;
    final String email;
    final String phone;
    final DateTime createdAt;
    final int v;
    final String? documentType;

    Patient({
        required this.id,
        required this.clinicId,
        required this.name,
        required this.documentId,
        required this.email,
        required this.phone,
        required this.createdAt,
        required this.v,
        this.documentType,
    });

}
