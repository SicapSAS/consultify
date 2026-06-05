import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para inhabilitar un paciente.
class DeactivatePatientDialog {
  DeactivatePatientDialog._();

  static Future<bool> showDisable(BuildContext context, Patient patient) {
    return ConfirmActionDialog.show(
      context,
      title: 'Inhabilitar paciente',
      message:
          '¿Deseas inhabilitar a "${patient.name}"? El paciente quedará marcado como inactivo.',
      confirmLabel: 'Inhabilitar',
      isDestructive: true,
    );
  }

  static Future<bool> showEnable(BuildContext context, Patient patient) {
    return ConfirmActionDialog.show(
      context,
      title: 'Habilitar paciente',
      message:
          '¿Deseas habilitar a "${patient.name}"? El paciente quedará marcado como activo.',
      confirmLabel: 'Habilitar',
    );
  }
}
