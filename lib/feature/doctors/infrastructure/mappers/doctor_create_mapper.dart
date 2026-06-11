
import 'package:consultify/feature/feature.dart';

class DoctorCreateMapper {
  static DoctorCreate fromJson(Map<String, dynamic> json) {
    return DoctorCreate(
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      password: json['password']?.toString() ?? '',
      specialty: json['specialty']?.toString() ?? 'Odontología General',
      documentType: json['documentType']?.toString() ?? 'CC',
      documentId: json['documentId']?.toString() ?? '',
      professionalCardNumber: json['professionalCardNumber']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> toJson(DoctorCreate doctor) {
    return {
      'name': doctor.name,
      'email': doctor.email,
      'password': doctor.password,
      'specialty': doctor.specialty,
      'documentType': doctor.documentType,
      'documentId': doctor.documentId,
      'professionalCardNumber': doctor.professionalCardNumber,
    };
  }
}