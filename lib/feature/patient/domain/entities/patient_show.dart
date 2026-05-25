class PatientShow {
  final PatientDetail patient;
  final int total;
  final List<AppointmentDetail> upcoming;
  final List<AppointmentDetail> past;
  final List<AppointmentDetail> appointments;

  PatientShow({
    required this.patient,
    required this.total,
    required this.upcoming,
    required this.past,
    required this.appointments,
  });
}

class PatientDetail {
  final String id;
  final String name;
  final String documentType;
  final String documentId;
  final bool isActive;

  PatientDetail({
    required this.id,
    required this.name,
    required this.documentType,
    required this.documentId,
    required this.isActive,
  });
}

class AppointmentDetail {
  final String id;
  final String clinicId;
  final String patientId;
  final ProfessionalDetail professional;
  final DateTime dateTime;
  final int durationMinutes;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final String notes;
  final String evolutionNotes;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AppointmentDetail({
    required this.id,
    required this.clinicId,
    required this.patientId,
    required this.professional,
    required this.dateTime,
    required this.durationMinutes,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.notes,
    required this.evolutionNotes,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}

class ProfessionalDetail {
  final String id;
  final String name;
  final String specialty;

  ProfessionalDetail({
    required this.id,
    required this.name,
    required this.specialty,
  });
}