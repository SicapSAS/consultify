

import 'package:consultify/feature/feature.dart'; // Tu entidad SpecialityUpdate

class SpecialtyUpdateMapper {
  static Map<String, dynamic> toJson(SpecialityUpdate specialty) {
    return {
      'name': specialty.name,
      'description': specialty.description ?? '',
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