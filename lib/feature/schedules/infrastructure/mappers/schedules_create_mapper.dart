import 'package:consultify/feature/feature.dart';

class ScheduleCreateMapper {
  static Map<String, dynamic> toJson(ScheduleCreate schedule) {
    return {
      'professionalId': schedule.professionalId,
      'appointmentDurationMinutes': schedule.appointmentDurationMinutes,
      'workingHours': _workingHoursToJson(schedule.workingHours),
      'workDays': schedule.workDays,
    };
  }

  static Map<String, dynamic> _workingHoursToJson(WorkingHours workingHours) {
    return {
      'morning': _timeBlockToJson(workingHours.morning),
      'afternoon': _timeBlockToJson(workingHours.afternoon),
    };
  }

  static Map<String, dynamic> _timeBlockToJson(Afternoon timeBlock) {
    return {
      'start': timeBlock.start,
      'end': timeBlock.end,
    };
  }
}