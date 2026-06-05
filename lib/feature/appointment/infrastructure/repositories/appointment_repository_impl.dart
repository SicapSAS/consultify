import 'package:consultify/feature/feature.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource dataSource;

  AppointmentRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter) {
    return dataSource.getAppointments(filter);
  }
}