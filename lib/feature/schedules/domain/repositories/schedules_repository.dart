import 'package:consultify/feature/feature.dart';



abstract class SchedulesRepository {
  Future<ShowSchedule> createDoctorSchedule(ScheduleCreate scheduleCreate);
}