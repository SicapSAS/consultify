import 'package:intl/intl.dart';

// 🩺 Payload para registrar la evolución médica de la cita
class AppointmentAttend {
  final String evolutionNotes;

  AppointmentAttend({required this.evolutionNotes});

  Map<String, dynamic> toJson() => {
    'evolutionNotes': evolutionNotes,
  };
}

// ❌ Payload para registrar la razón de cancelación de la cita
class AppointmentCancel {
  final String cancellationReason;

  AppointmentCancel({required this.cancellationReason});

  Map<String, dynamic> toJson() => {
    'cancellationReason': cancellationReason,
  };
}

// 📦 Mapper implícito para serializar el estado y re-agenda sin romper nulos
class AppointmentStatusMapper {
  static Map<String, dynamic> toJson(dynamic statusEntity) {
    final Map<String, dynamic> data = {};
    
    if (statusEntity.status != null) data['status'] = statusEntity.status;
    if (statusEntity.paymentStatus != null) data['paymentStatus'] = statusEntity.paymentStatus;
    if (statusEntity.paymentMethod != null) data['paymentMethod'] = statusEntity.paymentMethod;
    if (statusEntity.amount != null) data['amount'] = statusEntity.amount;
    
    // Convertir DateTime a string limpio YYYY-MM-DD para la API
    data['date'] = DateFormat('yyyy-MM-dd').format(statusEntity.date);
    data['time'] = statusEntity.time;
    
    return data;
  }
}

class AppointmentCreateMapper {
  static Map<String, dynamic> toJson(dynamic entity) {
    return {
      'patientId': entity.patientId,
      'professionalId': entity.professionalId,
      'date': DateFormat('yyyy-MM-dd').format(entity.date),
      'time': entity.time,
      'notes': entity.notes,
    };
  }
}