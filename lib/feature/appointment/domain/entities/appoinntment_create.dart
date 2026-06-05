class AppointmentCreate {
    final String patientId;
    final String professionalId;
    final DateTime date;
    final String time;
    final String notes;

    AppointmentCreate({
        required this.patientId,
        required this.professionalId,
        required this.date,
        required this.time,
        required this.notes,
    });

}