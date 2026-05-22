import 'package:consultify/feature/feature.dart';

class CreateClinicMapper {
  static CreateClinic fromJson(Map<String, dynamic> json) {
    return CreateClinic(
      name: json['name']?.toString() ?? '',
      nit: json['nit']?.toString() ?? '',
      streetAddress: json['streetAddress']?.toString() ?? json['address']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> toJson(CreateClinic clinic) {
    return {
      'name': clinic.name,
      'nit': clinic.nit,
      'streetAddress': clinic.streetAddress, // 🔑 Corregido para que coincida con el backend
      'city': clinic.city,
      'phone': clinic.phone,
      'email': clinic.email,
    };
  }
}