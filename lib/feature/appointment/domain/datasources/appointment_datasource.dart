import 'package:consultify/feature/feature.dart';



abstract class AppointmentDataSource {
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter);
}