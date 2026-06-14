import 'package:consultify/feature/feature.dart';

class DoctorShowMapper {
  static DcotorShow fromJson(Map<String, dynamic> json) {
    return DcotorShow(
      doctor: _showDoctorFromJson(json['doctor'] ?? {}),
      schedule: _showScheduleFromJson(json['schedule'] ?? {}),
    );
  }

  static ShowDoctor _showDoctorFromJson(Map<String, dynamic> json) {
    return ShowDoctor(
      id: json['_id']?.toString() ?? '',
      clinicId: json['clinicId']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? 'PROFESSIONAL',
      specialty: json['specialty']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? false,
      documentType: json['documentType']?.toString() ?? '',
      documentId: json['documentId']?.toString() ?? '',
      professionalCardNumber: json['professionalCardNumber']?.toString() ?? '',
      createdAtFormatted: json['createdAtFormatted']?.toString() ?? '',
    );
  }

  static ShowSchedule _showScheduleFromJson(Map<String, dynamic> json) {
    return ShowSchedule(
      id: json['_id']?.toString() ?? '',
      professionalId: json['professionalId']?.toString() ?? '',
      clinicId: json['clinicId']?.toString() ?? '',
      v: json['__v'] as int? ?? 0,
      appointmentDurationMinutes: json['appointmentDurationMinutes'] as int? ?? 20,
      createdTime: json['createdTime']?.toString() ?? '',
      createdAtFormatted: json['createdAtFormatted']?.toString() ?? '',
      updatedTime: json['updatedTime']?.toString() ?? '',
      updatedAtFormatted: json['updatedAtFormatted']?.toString() ?? '',
      workDays: List<int>.from(json['workDays'] ?? []),
      createdDate: json['createdDate'] != null 
          ? DateTime.parse(json['createdDate']) 
          : DateTime.now(),
      updatedDate: json['updatedDate'] != null 
          ? DateTime.parse(json['updatedDate']) 
          : DateTime.now(),
      workingHours: _workingHoursFromJson(json['workingHours'] ?? {}),
    );
  }

  static ShowWorkingHours _workingHoursFromJson(Map<String, dynamic> json) {
    return ShowWorkingHours(
      morning: _afternoonFromJson(json['morning'] ?? {}),
      afternoon: _afternoonFromJson(json['afternoon'] ?? {}),
    );
  }

  static ShowAfternoon _afternoonFromJson(Map<String, dynamic> json) {
    return ShowAfternoon(
      start: json['start']?.toString() ?? '00:00',
      end: json['end']?.toString() ?? '00:00',
    );
  }
}