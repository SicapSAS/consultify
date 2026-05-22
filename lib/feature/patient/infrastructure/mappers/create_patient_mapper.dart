import 'package:consultify/feature/feature.dart'; // O la ruta a tu entidad CreatePatient

class CreatePatientMapper {
  static CreatePatient fromJson(Map<String, dynamic> json) {
    return CreatePatient(
      name: json['name']?.toString() ?? '',
      documentType: json['documentType']?.toString() ?? '',
      documentId: json['documentId']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> toJson(CreatePatient patient) {
    return {
      'name': patient.name,
      'documentType': patient.documentType,
      'documentId': patient.documentId,
      'email': patient.email,
      'phone': patient.phone,
    };
  }
}