import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para eliminar un doctor.
class DeleteDoctorDialog {
  DeleteDoctorDialog._();

  static Future<bool> show(BuildContext context, Doctor doctor) {
    return ConfirmActionDialog.show(
      context,
      title: 'Eliminar doctor',
      message:
          '¿Deseas eliminar a "${doctor.name}"? Esta acción no se puede deshacer.',
      confirmLabel: 'Eliminar',
      isDestructive: true,
    );
  }
}
