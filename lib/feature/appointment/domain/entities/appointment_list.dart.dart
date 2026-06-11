class AppointmentList {
    final String id;
    final String clinicId;
    final AppointmentPatientId patientId;
    final AppointmentProfessionalId professionalId;
    final int durationMinutes;
    final String status;
    final String paymentStatus;
    final String paymentMethod;
    final String notes;
    final String? evolutionNotes;
    final int amount;
    final int v;
    final DateTime date;
    final String time;
    final String endTime;

    AppointmentList({
        required this.id,
        required this.clinicId,
        required this.patientId,
        required this.professionalId,
        required this.durationMinutes,
        required this.status,
        required this.paymentStatus,
        required this.paymentMethod,
        required this.notes,
        this.evolutionNotes,
        required this.amount,
        required this.v,
        required this.date,
        required this.time,
        required this.endTime,
    });

}

class AppointmentPatientId {
    final String id;
    final String name;
    final String documentId;
    final String phone;

    AppointmentPatientId({
        required this.id,
        required this.name,
        required this.documentId,
        required this.phone,
    });

}

class AppointmentProfessionalId {
    final String id;
    final String name;
    final String specialty;

    AppointmentProfessionalId({
        required this.id,
        required this.name,
        required this.specialty,
    });

}
