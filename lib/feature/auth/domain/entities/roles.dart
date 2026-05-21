/// Clase que centraliza los roles del sistema tal como están 
/// definidos en el backend (Mongoose Enums).
final class Roles {
  /// Rol con control total del sistema (Crear clínicas, etc.)
  static const String superAdmin = 'SUPER_ADMIN';

  /// Rol del personal administrativo / recepción (Agendar, Cobrar, Reagendar)
  static const String adminClinic = 'ADMIN_CLINIC';

  /// Rol del médico u odontólogo (Ver su agenda, adminicular/evolucionar citas)
  static const String professional = 'PROFESSIONAL';

  /// Roles vinculados a una clínica (el login devuelve `clinicId`).
  static bool isClinicScoped(String role) =>
      role == adminClinic || role == professional;

  // --- Métodos utilitarios opcionales para usar en las Vistas de Flutter ---

  /// Devuelve un nombre legible en español para mostrar en la UI de la App
  static String toDisplayString(String role) {
    switch (role) {
      case superAdmin:
        return 'Super Administrador';
      case adminClinic:
        return 'Recepcionista / Admin';
      case professional:
        return 'Odontólogo / Profesional';
      default:
        return 'Usuario';
    }
  }
}