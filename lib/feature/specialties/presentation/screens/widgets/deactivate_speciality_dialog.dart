import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para inhabilitar o habilitar una especialidad.
class DeactivateSpecialityDialog {
  DeactivateSpecialityDialog._();

  static Future<bool> showDisable(BuildContext context, Specialty specialty) {
    return ConfirmActionDialog.show(
      context,
      title: 'Inhabilitar especialidad',
      message:
          '¿Deseas inhabilitar "${specialty.name}"? La especialidad quedará marcada como inactiva.',
      confirmLabel: 'Inhabilitar',
      isDestructive: true,
    );
  }

  static Future<bool> showEnable(BuildContext context, Specialty specialty) {
    return ConfirmActionDialog.show(
      context,
      title: 'Habilitar especialidad',
      message:
          '¿Deseas habilitar "${specialty.name}"? La especialidad quedará marcada como activa.',
      confirmLabel: 'Habilitar',
    );
  }
}
