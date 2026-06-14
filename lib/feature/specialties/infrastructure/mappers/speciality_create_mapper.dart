import 'package:consultify/feature/feature.dart'; // Tu entidad SpecialityCreate

class SpecialtyCreateMapper {
  static Map<String, dynamic> toJson(SpecialityCreate specialty) {
    final description = specialty.description?.trim();

    return {
      'name': specialty.name,
      if (description != null && description.isNotEmpty)
        'description': description,
    };
  }
}