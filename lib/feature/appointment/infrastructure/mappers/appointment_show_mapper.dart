import 'package:consultify/feature/feature.dart';

class AppointmentShowMapper {
  static AppointmentShow fromJson(Map<String, dynamic> json) {
    // Tolerancia a respuestas envueltas en nodos 'appointment' o 'data'
    final cleanJson = json['appointment'] ?? json['data'] ?? json;

    return AppointmentShow(
      id: cleanJson['_id']?.toString() ?? '',
      clinicId: cleanJson['clinicId']?.toString() ?? '',
      patientId: _patientIdFromJson(cleanJson['patientId'] ?? {}),
      professionalId: _professionalIdFromJson(cleanJson['professionalId'] ?? {}),
      durationMinutes: cleanJson['durationMinutes'] as int? ?? 0,
      status: cleanJson['status']?.toString() ?? 'PENDING',
      paymentStatus: cleanJson['paymentStatus']?.toString() ?? 'PENDING',
      paymentMethod: cleanJson['paymentMethod']?.toString() ?? 'NONE',
      notes: cleanJson['notes']?.toString() ?? '',
      evolutionNotes: cleanJson['evolutionNotes']?.toString() ?? '',
      v: cleanJson['__v'] as int? ?? 0,
      amount: cleanJson['amount'] as int? ?? 0,
      date: cleanJson['date'] != null 
          ? DateTime.parse(cleanJson['date']) 
          : (cleanJson['dateTime'] != null ? DateTime.parse(cleanJson['dateTime']) : DateTime.now()),
      time: cleanJson['time']?.toString() ?? '',
      endTime: cleanJson['endTime']?.toString() ?? '',
    );
  }

  static PatientId _patientIdFromJson(Map<String, dynamic> json) {
    return PatientId(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      documentId: json['documentId']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      documentType: json['documentType']?.toString() ?? 'CC',
    );
  }

  static ProfessionalId _professionalIdFromJson(Map<String, dynamic> json) {
    return ProfessionalId(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Profesional',
      specialty: json['specialty']?.toString() ?? 'General',
    );
  }
}