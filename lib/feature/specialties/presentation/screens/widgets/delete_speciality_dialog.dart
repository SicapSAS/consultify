import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación para eliminar una especialidad.
class DeleteSpecialityDialog {
  DeleteSpecialityDialog._();

  static Future<bool> show(BuildContext context, Specialty specialty) {
    return ConfirmActionDialog.show(
      context,
      title: 'Eliminar especialidad',
      message:
          '¿Deseas eliminar "${specialty.name}"? Esta acción no se puede deshacer.',
      confirmLabel: 'Eliminar',
      isDestructive: true,
    );
  }
}
