import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para inhabilitar una clínica.
class DeactivateClinicDialog {
  DeactivateClinicDialog._();

  static Future<bool> show(BuildContext context, ListClinic clinic) {
    return ConfirmActionDialog.show(
      context,
      title: 'Inhabilitar clínica',
      message:
          '¿Deseas inhabilitar "${clinic.name}"? La clínica quedará marcada como inactiva.',
      confirmLabel: 'Inhabilitar',
      isDestructive: true,
    );
  }
}
