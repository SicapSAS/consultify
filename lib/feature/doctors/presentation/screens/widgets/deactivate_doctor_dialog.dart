import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para inhabilitar o habilitar un doctor.
class DeactivateDoctorDialog {
  DeactivateDoctorDialog._();

  static Future<bool> showDisable(BuildContext context, Doctor doctor) {
    return ConfirmActionDialog.show(
      context,
      title: 'Inhabilitar doctor',
      message:
          '¿Deseas inhabilitar a "${doctor.name}"? El doctor quedará marcado como inactivo.',
      confirmLabel: 'Inhabilitar',
      isDestructive: true,
    );
  }

  static Future<bool> showEnable(BuildContext context, Doctor doctor) {
    return ConfirmActionDialog.show(
      context,
      title: 'Habilitar doctor',
      message:
          '¿Deseas habilitar a "${doctor.name}"? El doctor quedará marcado como activo.',
      confirmLabel: 'Habilitar',
    );
  }
}
