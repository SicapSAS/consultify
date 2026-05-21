import 'package:consultify/feature/feature.dart';

class ListClinicMapper {
  static ListClinic fromJson(Map<String, dynamic> json) {
    return ListClinic(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin nombre',
      address: json['address']?.toString() ?? 'Sin dirección',
      phone: json['phone']?.toString() ?? 'Sin teléfono',
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : DateTime.now(),
      v: json['__v'] as int? ?? 0,
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