import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo para cancelar una cita con motivo opcional.
class CancelAppointmentDialog extends StatefulWidget {
  final AppointmentList appointment;

  const CancelAppointmentDialog({
    super.key,
    required this.appointment,
  });

  /// Retorna el motivo ingresado (puede ser vacío) o `null` si se cancela.
  static Future<String?> show(
    BuildContext context,
    AppointmentList appointment,
  ) {
    return showDialog<String>(
      context: context,
      builder: (ctx) => CancelAppointmentDialog(appointment: appointment),
    );
  }

  @override
  State<CancelAppointmentDialog> createState() => _CancelAppointmentDialogState();
}

class _CancelAppointmentDialogState extends State<CancelAppointmentDialog> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Text(
        'Cancelar cita',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '¿Deseas cancelar la cita de "${widget.appointment.patientId.name}"?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Motivo de cancelación',
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.7),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            CustomMultiLineFormField(
              controller: _reasonController,
              hintText: 'Escribe el motivo (opcional)',
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFilledButton(
              text: 'Volver',
              onPressed: () => Navigator.of(context).pop(),
              buttonColor: AppColors.disabledButton,
              textColor: AppColors.textSecondary,
            ),
            const SizedBox(width: 10),
            CustomFilledButton(
              text: 'Cancelar cita',
              onPressed: () => Navigator.of(context).pop(_reasonController.text),
              buttonColor: AppColors.errorBackground,
              textColor: AppColors.primary,
            ),
          ],
        ),
      ],
    );
  }
}
