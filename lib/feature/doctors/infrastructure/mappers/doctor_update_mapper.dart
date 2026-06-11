
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
    };

    if (doctor.password.trim().isNotEmpty) {
      data['password'] = doctor.password.trim();
    }

    return data;
  }
}
