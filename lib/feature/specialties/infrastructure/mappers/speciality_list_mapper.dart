import 'package:consultify/feature/feature.dart'; // Tu entidad Specialty

class SpecialtyListMapper {
  static Specialty fromJson(Map<String, dynamic> json) {
    // Extrae de forma segura si viene envuelto en nodos 'specialty' o 'data'
    final cleanJson = json['specialty'] ?? json['data'] ?? json;

    return Specialty(
      id: cleanJson['_id']?.toString() ?? '',
      clinicId: cleanJson['clinicId']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      description: cleanJson['description']?.toString() ?? '',
      isActive: cleanJson['isActive'] as bool? ?? false,
      createdDate: cleanJson['createdDate'] != null
          ? DateTime.parse(cleanJson['createdDate'].toString())
          : DateTime.now(),
      createdTime: cleanJson['createdTime']?.toString() ?? '',
    );
  }
}