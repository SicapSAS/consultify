import 'package:consultify/feature/feature.dart'; // O la ruta directa a tu modelo AppointmentList

class AppointmentListMapper {
  static AppointmentList fromJson(Map<String, dynamic> json) {
    return AppointmentList(
      id: json['_id']?.toString() ?? '',
      clinicId: json['clinicId']?.toString() ?? '',
      patientId: _patientIdFromJson(json['patientId'] ?? {}),
      professionalId: _professionalIdFromJson(json['professionalId'] ?? {}),
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      time: json['time']?.toString() ?? '',
      endTime: json['endTime']?.toString() ?? '',
      durationMinutes: json['durationMinutes'] as int? ?? 0,
      status: json['status']?.toString() ?? 'PENDING',
      paymentStatus: json['paymentStatus']?.toString() ?? 'PENDING',
      paymentMethod: json['paymentMethod']?.toString() ?? 'NONE',
      notes: json['notes']?.toString() ?? '',
      evolutionNotes: json['evolutionNotes']?.toString(),
      v: json['__v'] as int? ?? 0,
      amount: json['amount'] as int? ?? 0,
    );
  }

  static AppointmentPatientId _patientIdFromJson(Map<String, dynamic> json) {
    return AppointmentPatientId(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      documentId: json['documentId']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  static AppointmentProfessionalId _professionalIdFromJson(Map<String, dynamic> json) {
    return AppointmentProfessionalId(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Profesional',
      specialty: json['specialty']?.toString() ?? 'General',
    );
  }
}