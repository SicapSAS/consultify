import 'package:consultify/feature/feature.dart'; // O las rutas directas a tus entidades creadas arriba

class PatientShowMapper {
  
  static PatientShow fromJson(Map<String, dynamic> json) {
    return PatientShow(
      patient: _patientDetailFromJson(json['patient'] ?? {}),
      total: json['total'] as int? ?? 0,
      upcoming: (json['upcoming'] as List? ?? [])
          .map((item) => _appointmentDetailFromJson(item))
          .toList(),
      past: (json['past'] as List? ?? [])
          .map((item) => _appointmentDetailFromJson(item))
          .toList(),
      appointments: (json['appointments'] as List? ?? [])
          .map((item) => _appointmentDetailFromJson(item))
          .toList(),
    );
  }

  static PatientDetail _patientDetailFromJson(Map<String, dynamic> json) {
    return PatientDetail(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      documentType: json['documentType']?.toString() ?? 'CC',
      documentId: json['documentId']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  static AppointmentDetail _appointmentDetailFromJson(Map<String, dynamic> json) {
    return AppointmentDetail(
      id: json['_id']?.toString() ?? '',
      clinicId: json['clinicId']?.toString() ?? '',
      patientId: json['patientId']?.toString() ?? '',
      professional: _professionalDetailFromJson(json['professionalId'] ?? {}),
      dateTime: json['dateTime'] != null 
          ? DateTime.parse(json['dateTime']) 
          : DateTime.now(),
      durationMinutes: json['durationMinutes'] as int? ?? 0,
      status: json['status']?.toString() ?? 'PENDING',
      paymentStatus: json['paymentStatus']?.toString() ?? 'PENDING',
      paymentMethod: json['paymentMethod']?.toString() ?? 'NONE',
      notes: json['notes']?.toString() ?? '',
      evolutionNotes: json['evolutionNotes']?.toString() ?? '',
      amount: json['amount'] as int? ?? 0,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : DateTime.now(),
      v: json['__v'] as int? ?? 0,
    );
  }

  static ProfessionalDetail _professionalDetailFromJson(Map<String, dynamic> json) {
    return ProfessionalDetail(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Profesional Externo',
      specialty: json['specialty']?.toString() ?? 'General',
    );
  }
}