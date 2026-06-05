import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para inhabilitar un paciente.
class DeactivatePatientDialog {
  DeactivatePatientDialog._();

  static Future<bool> show(BuildContext context, Patient patient) {
    return ConfirmActionDialog.show(
      context,
      title: 'Inhabilitar paciente',
      message:
          '¿Deseas inhabilitar a "${patient.name}"? El paciente quedará marcado como inactivo.',
      confirmLabel: 'Inhabilitar',
      isDestructive: true,
    );
  }
}
