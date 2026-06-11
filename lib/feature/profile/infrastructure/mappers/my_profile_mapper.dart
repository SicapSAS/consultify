import 'package:consultify/feature/feature.dart'; // O la ruta directa a tus entidades MyProfileEntity y Clinic

class MyProfileMapper {
  static MyProfileEntity fromJson(Map<String, dynamic> json) {
    // Tolerancia por si la respuesta viene envuelta en un nodo secundario
    final cleanJson = json['user'] ?? json['data'] ?? json;

    return MyProfileEntity(
      id: cleanJson['_id']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      email: cleanJson['email']?.toString() ?? '',
      role: cleanJson['role']?.toString() ?? 'USER',
      roleLabel: cleanJson['roleLabel']?.toString() ?? 'Usuario',
      specialty: cleanJson['specialty']?.toString() ?? '',
      professionalCardNumber: cleanJson['professionalCardNumber']?.toString() ?? '',
      documentType: cleanJson['documentType']?.toString() ?? 'CC',
      documentId: cleanJson['documentId']?.toString() ?? '',
      isActive: cleanJson['isActive'] as bool? ?? false,
      createdDate: cleanJson['createdDate'] != null
          ? DateTime.parse(cleanJson['createdDate'].toString())
          : DateTime.now(),
      createdTime: cleanJson['createdTime']?.toString() ?? '',
      createdAtFormatted: cleanJson['createdAtFormatted']?.toString() ?? '',
      clinic: _clinicFromJson(cleanJson['clinic'] ?? {}),
    );
  }

  static Clinic _clinicFromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Sin clínica asignada',
      phone: json['phone']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toJson(MyProfileEntity entity) {
    return {
      '_id': entity.id,
      'name': entity.name,
      'email': entity.email,
      'role': entity.role,
      'roleLabel': entity.roleLabel,
      'specialty': entity.specialty,
      'professionalCardNumber': entity.professionalCardNumber,
      'documentType': entity.documentType,
      'documentId': entity.documentId,
      'isActive': entity.isActive,
      'createdDate': entity.createdDate.toIso8601String().split('T')[0], // Guarda solo YYYY-MM-DD
      'createdTime': entity.createdTime,
      'createdAtFormatted': entity.createdAtFormatted,
      'clinic': {
        '_id': entity.clinic.id,
        'name': entity.clinic.name,
        'phone': entity.clinic.phone,
        'isActive': entity.clinic.isActive,
      },
    };
  }
}