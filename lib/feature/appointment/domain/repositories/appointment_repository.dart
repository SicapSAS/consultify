import 'package:consultify/feature/feature.dart';



abstract class AppointmentRepository {
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter);
  Future<AppointmentShow> getAppointmentById(String id);
  Future<AppointmentShow> createAppointment(AppointmentCreate appointmentCreate);
  Future<AppointmentShow> updateAppointmentStatus(String id, AppointmentStatus status);
  Future<AppointmentShow> attendAppointment(String id, AppointmentAttend attend);
  Future<AppointmentShow> cancelAppointment(String id, AppointmentCancel cancel);
}