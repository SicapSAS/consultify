import 'package:consultify/feature/feature.dart'; // O la ruta a tu entidad Patient

class ListPatientMapper {
  static Patient fromJson(Map<String, dynamic> json) {
    // Extrae de forma segura si viene envuelto desde el backend
    final cleanJson = json['data'] ?? json['patient'] ?? json;

    return Patient(
      id: cleanJson['_id']?.toString() ?? '',
      clinicId: cleanJson['clinicId']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      documentId: cleanJson['documentId']?.toString() ?? '',
      email: cleanJson['email']?.toString() ?? '',
      phone: cleanJson['phone']?.toString() ?? '',
      v: cleanJson['__v'] as int? ?? 0,
      documentType: cleanJson['documentType']?.toString(),
      createdAt: cleanJson['createdAt'] != null
          ? DateTime.parse(cleanJson['createdAt'])
          : DateTime.now(),
      isActive: cleanJson['isActive'] as bool? ?? true,
    );
  }

  static Map<String, dynamic> toJson(Patient patient) {
    return {
      '_id': patient.id,
      'clinicId': patient.clinicId,
      'name': patient.name,
      'documentId': patient.documentId,
      'email': patient.email,
      'phone': patient.phone,
      'documentType': patient.documentType,
      'createdAt': patient.createdAt.toIso8601String(),
      '__v': patient.v,
      'isActive': patient.isActive,
    };
  }
}