class DcotorShow {
    final ShowDoctor doctor;
    final ShowSchedule schedule;

    DcotorShow({
        required this.doctor,
        required this.schedule,
    });

}

class ShowDoctor {
    final String id;
    final String clinicId;
    final String name;
    final String email;
    final String role;
    final String specialty;
    final bool isActive;
    final String documentType;
    final String documentId;
    final String professionalCardNumber;
    final String createdAtFormatted;

    ShowDoctor({
        required this.id,
        required this.clinicId,
        required this.name,
        required this.email,
        required this.role,
        required this.specialty,
        required this.isActive,
        required this.documentType,
        required this.documentId,
        required this.professionalCardNumber,
        required this.createdAtFormatted,
    });

}

class ShowSchedule {
    final ShowWorkingHours workingHours;
    final String id;
    final String professionalId;
    final int v;
    final int appointmentDurationMinutes;
    final String clinicId;
    final DateTime createdDate;
    final String createdTime;
    final String createdAtFormatted;
    final DateTime updatedDate;
    final String updatedTime;
    final String updatedAtFormatted;
    final List<int> workDays;

    ShowSchedule({
        required this.workingHours,
        required this.id,
        required this.professionalId,
        required this.v,
        required this.appointmentDurationMinutes,
        required this.clinicId,
        required this.createdDate,
        required this.createdTime,
        required this.createdAtFormatted,
        required this.updatedDate,
        required this.updatedTime,
        required this.updatedAtFormatted,
        required this.workDays,
    });

}

class ShowWorkingHours {
    final ShowAfternoon morning;
    final ShowAfternoon afternoon;

    ShowWorkingHours({
        required this.morning,
        required this.afternoon,
    });

}

class ShowAfternoon {
    final String start;
    final String end;

    ShowAfternoon({
        required this.start,
        required this.end,
    });

}
