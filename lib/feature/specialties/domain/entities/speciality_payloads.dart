

// sirve para actualizar una especialidad
class SpecialityUpdate {
    final String name;
    final String? description;

    SpecialityUpdate({
        required this.name,
        this.description,
    });

}

// sirve para activar o desactivar una especialidad
class SpecialityActive {
    final bool isActive;

    SpecialityActive({
        required this.isActive,
    });

}

