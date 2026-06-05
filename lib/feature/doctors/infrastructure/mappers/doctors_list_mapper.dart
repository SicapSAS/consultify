import 'package:consultify/feature/feature.dart'; // O la ruta directa a tu modelo Doctor

class DoctorListMapper {
  static Doctor fromJson(Map<String, dynamic> json) {
    // Si la respuesta viene envuelta en un nodo secundario, lo extraemos
    final cleanJson = json['data'] ?? json['doctor'] ?? json;

    return Doctor(
      id: cleanJson['_id']?.toString() ?? '',
      clinicId: cleanJson['clinicId']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      email: cleanJson['email']?.toString() ?? '',
      role: cleanJson['role']?.toString() ?? 'PROFESSIONAL',
      specialty: cleanJson['specialty']?.toString() ?? 'Odontología General',
      isActive: cleanJson['isActive'] as bool? ?? false,
      documentType: cleanJson['documentType']?.toString() ?? '',
      documentId: cleanJson['documentId']?.toString() ?? '',
      professionalCardNumber: cleanJson['professionalCardNumber']?.toString() ?? '',
      createdAtFormatted: cleanJson['createdAtFormatted']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> toJson(Doctor doctor) {
    return {
      '_id': doctor.id,
      'clinicId': doctor.clinicId,
      'name': doctor.name,
      'email': doctor.email,
      'role': doctor.role,
      'specialty': doctor.specialty,
      'isActive': doctor.isActive,
      'documentType': doctor.documentType,
      'documentId': doctor.documentId,
      'professionalCardNumber': doctor.professionalCardNumber,
      'createdAtFormatted': doctor.createdAtFormatted,
    };
  }
}