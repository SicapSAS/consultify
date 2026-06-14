import 'package:consultify/feature/feature.dart'; // Tu entidad SpecialityCreate

class SpecialtyCreateMapper {
  static Map<String, dynamic> toJson(SpecialityCreate specialty) {
    return {
      'name': specialty.name,
      'description': specialty.description ?? '',
    };
  }
}