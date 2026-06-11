
import 'package:consultify/feature/feature.dart';

class DoctorUpdateMapper {
  static Map<String, dynamic> toJson(DoctorUpdate doctor) {
    final Map<String, dynamic> data = {
      'name': doctor.name,
      'email': doctor.email,
      'specialty': doctor.specialty,
      'professionalCardNumber': doctor.professionalCardNumber,
      'documentType': doctor.documentType,
      'documentId': doctor.documentId,
      'isActive': doctor.isActive,
    };

    // 🔑 Si la contraseña no está en blanco, la incluimos en el payload de actualización
    if (doctor.password.trim().isNotEmpty) {
      data['password'] = doctor.password;
    }

    return data;
  }
}