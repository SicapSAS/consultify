import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo para confirmar una cita validando que el pago esté completado.
class ConfirmAppointmentDialog extends StatelessWidget {
  final AppointmentList appointment;

  const ConfirmAppointmentDialog({
    super.key,
    required this.appointment,
  });

  static Future<bool> show(
    BuildContext context,
    AppointmentList appointment,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmAppointmentDialog(appointment: appointment),
    );
    return result ?? false;
  }

  bool get _canConfirm => AppointmentPaymentHelpers.canConfirmAppointment(appointment);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Text(
        'Confirmar cita',
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
              'Paciente: ${appointment.patientId.name}',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            if (!_canConfirm) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warningBackground.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.warningBackground.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'No se puede confirmar la cita. Falta registrar el pago.',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            _ConfirmInfoRow(
              label: 'Estado de pago',
              value: AppointmentDetailHelpers.paymentLabel(appointment.paymentStatus),
            ),
            const SizedBox(height: 10),
            _ConfirmInfoRow(
              label: 'Método de pago',
              value: AppointmentDetailHelpers.paymentMethodLabel(
                appointment.paymentMethod,
              ),
            ),
            const SizedBox(height: 10),
            _ConfirmInfoRow(
              label: 'Valor de pago',
              value: AppointmentDetailHelpers.formatAmount(appointment.amount),
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
              onPressed: () => Navigator.of(context).pop(false),
              buttonColor: AppColors.disabledButton,
              textColor: AppColors.textSecondary,
            ),
            if (_canConfirm) ...[
              const SizedBox(width: 10),
              CustomFilledButton(
                text: 'Confirmar cita',
                onPressed: () => Navigator.of(context).pop(true),
                buttonColor: AppColors.secondaryButton,
                textColor: AppColors.secondaryBackground,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _ConfirmInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _ConfirmInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.6),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
