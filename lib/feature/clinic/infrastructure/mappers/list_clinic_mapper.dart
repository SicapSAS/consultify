import 'package:consultify/feature/feature.dart';

class ListClinicMapper {
  static ListClinic fromJson(Map<String, dynamic> json) {
    final cleanJson = json['data'] ?? json;
    return ListClinic(
      id: cleanJson['_id']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      address: cleanJson['address']?.toString() ?? 'Sin dirección',
      phone: cleanJson['phone']?.toString() ?? 'Sin teléfono',
      createdAt: cleanJson['createdAt'] != null 
          ? DateTime.parse(cleanJson['createdAt']) 
          : DateTime.now(),
      v: cleanJson['__v'] as int? ?? 0,
    );
  }

  static Map<String, dynamic> toJson(ListClinic clinic) {
    return {
      '_id': clinic.id,
      'name': clinic.name,
      'address': clinic.address,
      'phone': clinic.phone,
      'createdAt': clinic.createdAt.toIso8601String(),
      '__v': clinic.v,
    };
  }
}