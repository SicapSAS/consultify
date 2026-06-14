class ScheduleCreate {
    final String professionalId;
    final int appointmentDurationMinutes;
    final WorkingHours workingHours;
    final List<int> workDays;

    ScheduleCreate({
        required this.professionalId,
        required this.appointmentDurationMinutes,
        required this.workingHours,
        required this.workDays,
    });

}

class WorkingHours {
    final Afternoon morning;
    final Afternoon afternoon;

    WorkingHours({
        required this.morning,
        required this.afternoon,
    });

}

class Afternoon {
    final String start;
    final String end;

    Afternoon({
        required this.start,
        required this.end,
    });

}
