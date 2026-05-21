import 'package:consultify/feature/feature.dart';


class CreateClinicMapper {
  static CreateClinic fromJson(Map<String, dynamic> json) {
    return CreateClinic(
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  static Map<String, dynamic> toJson(CreateClinic clinic) {
    return {
      'name': clinic.name,
      'address': clinic.address,
      'phone': clinic.phone,
    };
  }
}