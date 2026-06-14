class SpecialityList {
    final int total;
    final List<Specialty> specialties;

    SpecialityList({
        required this.total,
        required this.specialties,
    });

}

class Specialty {
    final String id;
    final String clinicId;
    final String name;
    final String description;
    final bool isActive;
    final DateTime createdDate;
    final String createdTime;

    Specialty({
        required this.id,
        required this.clinicId,
        required this.name,
        required this.description,
        required this.isActive,
        required this.createdDate,
        required this.createdTime,
    });

}
