import 'package:consultify/feature/feature.dart';

class ListClinicMapper {
  static ListClinic fromJson(Map<String, dynamic> json) {
    // Si la respuesta viene envuelta en un objeto 'data' o 'clinic', lo extraemos. 
    // Si viene plano, usa el json raíz.
    final cleanJson = json['data'] ?? json['clinic'] ?? json;

    return ListClinic(
      id: cleanJson['_id']?.toString() ?? '',
      name: cleanJson['name']?.toString() ?? 'Sin nombre',
      phone: cleanJson['phone']?.toString() ?? 'Sin teléfono',
      
      // Mapeo de campos requeridos por el constructor
      isActive: cleanJson['isActive'] as bool? ?? true,
      v: cleanJson['__v'] as int? ?? 0, // Requerido por tu modelo
      createdAt: cleanJson['createdAt'] != null
          ? DateTime.parse(cleanJson['createdAt'])
          : DateTime.now(),

      // Mapeo de campos opcionales (String?) respetando la estructura de tu entidad
      nit: cleanJson['nit']?.toString(),
      streetAddress: cleanJson['streetAddress']?.toString(), // 🔑 Corregido: Nombre exacto en el constructor
      city: cleanJson['city']?.toString(), // 🔑 Agregado: Faltaba mapear la ciudad
      email: cleanJson['email']?.toString(),
      address: cleanJson['streetAddress']?.toString() ?? cleanJson['address']?.toString(),
    );
  }

  static Map<String, dynamic> toJson(ListClinic clinic) {
    return {
      '_id': clinic.id,
      'name': clinic.name,
      'nit': clinic.nit,
      'streetAddress': clinic.streetAddress, // Mapeo nativo hacia Mongoose
      'city': clinic.city,
      'phone': clinic.phone,
      'email': clinic.email,
      'isActive': clinic.isActive,
      'createdAt': clinic.createdAt.toIso8601String(),
      '__v': clinic.v,
      'address': clinic.address,
    };
  }
}