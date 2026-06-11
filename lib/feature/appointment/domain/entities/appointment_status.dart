class AppointmentStatus {
  // campos opcionales para la actualización de la cita y agregar el valor de pago
    final String? status; // cuando se actualiza el pago, se debe cambiar el estado a CONFIRMED
    final String? paymentStatus; // cuando se actualiza el pago, se debe cambiar el estado a COMPLETED
    final String? paymentMethod; // cuando se actualiza el pago, se debe cambiar el estado a CASH
    final int? amount;

    // campos obligatorios para la actualizacion de la cita
    final DateTime date;
    final String time;

    AppointmentStatus({
        this.status,
        this.paymentStatus,
        this.paymentMethod,
        this.amount,
        required this.date,
        required this.time,
    });

}
