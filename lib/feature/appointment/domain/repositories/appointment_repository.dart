import 'package:consultify/feature/feature.dart';



abstract class AppointmentRepository {
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter);
}