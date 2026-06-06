import 'package:consultify/feature/feature.dart';

class AppointmentPaymentHelpers {
  static bool isPaymentCompleted(String paymentStatus) {
    final status = paymentStatus.toUpperCase();
    return status == 'PAID' || status == 'COMPLETED';
  }

  static bool hasValidPaymentMethod(String paymentMethod) {
    final method = paymentMethod.trim().toUpperCase();
    return method.isNotEmpty && method != 'NONE';
  }

  static bool canConfirmAppointment(AppointmentList appointment) {
    return isPaymentCompleted(appointment.paymentStatus) &&
        appointment.amount > 0 &&
        hasValidPaymentMethod(appointment.paymentMethod);
  }
}
