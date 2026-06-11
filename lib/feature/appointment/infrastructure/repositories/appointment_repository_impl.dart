import 'package:consultify/feature/feature.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource dataSource;

  AppointmentRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter) {
    return dataSource.getAppointments(filter);
  }
  
  @override
  Future<AppointmentShow> attendAppointment(String id, AppointmentAttend attend) {
    return dataSource.attendAppointment(id, attend);
  }
  
  @override
  Future<AppointmentShow> cancelAppointment(String id, AppointmentCancel cancel) {
    return dataSource.cancelAppointment(id, cancel);
  }
  
  @override
  Future<AppointmentShow> createAppointment(AppointmentCreate appointmentCreate) {
    return dataSource.createAppointment(appointmentCreate);
  }
  
  @override
  Future<AppointmentShow> getAppointmentById(String id) {
    return dataSource.getAppointmentById(id);
  }
  
  @override
  Future<AppointmentShow> updateAppointmentStatus(String id, AppointmentStatus status) {
    return dataSource.updateAppointmentStatus(id, status);
  }
}