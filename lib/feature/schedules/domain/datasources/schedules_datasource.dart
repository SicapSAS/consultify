import 'package:consultify/feature/feature.dart';



abstract class SchedulesDataSource {
  Future<ShowSchedule> createDoctorSchedule(ScheduleCreate scheduleCreate);
}