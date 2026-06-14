

import 'package:consultify/feature/feature.dart'; // Tu entidad SpecialityUpdate

class SpecialtyUpdateMapper {
  static Map<String, dynamic> toJson(SpecialityUpdate specialty) {
    final description = specialty.description?.trim();

    return {
      'name': specialty.name,
      if (description != null && description.isNotEmpty)
        'description': description,
    };
  }
}

class SpecialtyActiveMapper {
  static Map<String, dynamic> toJson(SpecialityActive specialtyActive) {
    return {
      'isActive': specialtyActive.isActive,
    };
  }
}