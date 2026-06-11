
class AppointmentShow {
    final String id;
    final String clinicId;
    final PatientId patientId;
    final ProfessionalId professionalId;
    final int durationMinutes;
    final String status;
    final String paymentStatus;
    final String paymentMethod;
    final String notes;
    final String evolutionNotes;
    final int v;
    final int amount;
    final DateTime date;
    final String time;
    final String endTime;

    AppointmentShow({
        required this.id,
        required this.clinicId,
        required this.patientId,
        required this.professionalId,
        required this.durationMinutes,
        required this.status,
        required this.paymentStatus,
        required this.paymentMethod,
        required this.notes,
        required this.evolutionNotes,
        required this.v,
        required this.amount,
        required this.date,
        required this.time,
        required this.endTime,
    });

}

class PatientId {
    final String id;
    final String name;
    final String documentId;
    final String email;
    final String phone;
    final String documentType;

    PatientId({
        required this.id,
        required this.name,
        required this.documentId,
        required this.email,
        required this.phone,
        required this.documentType,
    });

}

class ProfessionalId {
    final String id;
    final String name;
    final String specialty;

    ProfessionalId({
        required this.id,
        required this.name,
        required this.specialty,
    });

}
