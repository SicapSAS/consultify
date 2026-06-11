class DoctorUpdate {

    // Campos para actualizar el doctor, todos son OPCIONALES.
    final String name;
    final String email;
    final String specialty;
    final String professionalCardNumber;
    final String documentType;
    final String documentId;

    /// Este campo solo se usa para inhabilitar o habilitar el doctor. olo funciona con el boon de Inhabilitar/Habilitar.
    final bool isActive;

    /// Si se desea cambiar la contraseña, se debe proporcionar, si no, se debe dejar en blanco.
    final String password;

    DoctorUpdate({
        required this.name,
        required this.email,
        required this.specialty,
        required this.professionalCardNumber,
        required this.documentType,
        required this.documentId,
        required this.isActive,
        required this.password,
    });

}
