

import 'package:consultify/feature/feature.dart';

class SchedulesRepositoryImpl implements SchedulesRepository {
  final SchedulesDataSource dataSource;

  SchedulesRepositoryImpl({required this.dataSource});

  @override
  Future<ShowSchedule> createDoctorSchedule(ScheduleCreate scheduleCreate) {
    return dataSource.createDoctorSchedule(scheduleCreate);
  }
}