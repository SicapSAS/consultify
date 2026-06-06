import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientAppointmentTile extends StatelessWidget {
  final AppointmentDetail appointment;

  const PatientAppointmentTile({
    super.key,
    required this.appointment,
  });

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year · $hour:$minute';
  }

  String _statusLabel(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return 'Pendiente';
      case 'CONFIRMED':
        return 'Confirmada';
      case 'COMPLETED':
        return 'Completada';
      case 'ATTENDED':
        return 'Atendida';
      case 'NOT_ATTENDED':
        return 'No atendida';
      case 'CANCELLED':
        return 'Cancelada';
      default:
        return status;
    }
  }

  Color _statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return AppColors.warningBackground;
      case 'CONFIRMED':
        return AppColors.infoBackground;
      case 'COMPLETED':
        return AppColors.successBackground;
      case 'ATTENDED':
        return AppColors.successBackground;
      case 'NOT_ATTENDED':
        return AppColors.disabledBackground;
      case 'CANCELLED':
        return AppColors.disabledBackground;
      default:
        return AppColors.textPrimary;
    }
  }

  String _paymentLabel(String paymentStatus) {
    switch (paymentStatus.toUpperCase()) {
      case 'PAID':
      case 'COMPLETED':
        return 'Pagado';
      case 'PENDING':
        return 'Pago pendiente';
      case 'NONE':
        return 'Sin pago';
      default:
        return paymentStatus;
    }
  }

  bool _hasText(String? value) {
    if (value == null) return false;
    return value.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final radius = 12.0;
    final rowGap = 8.0;
    final cardPadding = 16.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3)
          )
        ]
      ),
      padding: EdgeInsets.all(cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _formatDateTime(appointment.dateTime),
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700
                  )
                )
              ),
              StatusBadge(
                label: _statusLabel(appointment.status),
                accentColor: _statusColor(appointment.status)
              )
            ]
          ),
          SizedBox(height: rowGap),
          _AppointmentDetailRow(
            icon: FontAwesomeIcons.userDoctor.data,
            text: appointment.professional.name
          ),
          if (_hasText(appointment.professional.specialty)) ...[
            SizedBox(height: rowGap),
            _AppointmentDetailRow(
              icon: FontAwesomeIcons.stethoscope.data,
              text: appointment.professional.specialty
            )
          ],
          SizedBox(height: rowGap),
          _AppointmentDetailRow(
            icon: FontAwesomeIcons.clock.data,
            text: '${appointment.durationMinutes} min'
          ),
          SizedBox(height: rowGap),
          _AppointmentDetailRow(
            icon: FontAwesomeIcons.moneyBill.data,
            text: _paymentLabel(appointment.paymentStatus)
          ),
          if (_hasText(appointment.notes)) ...[
            SizedBox(height: rowGap),
            _AppointmentDetailRow(
              icon: FontAwesomeIcons.noteSticky.data,
              label: 'Notas',
              text: appointment.notes.trim()
            )
          ],
          if (_hasText(appointment.evolutionNotes)) ...[
            SizedBox(height: 12),
            _EvolutionNotesSection(
              evolutionNotes: appointment.evolutionNotes.trim()
            )
          ]
        ]
      )
    );
  }
}

class _AppointmentDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? label;

  const _AppointmentDetailRow({
    required this.icon,
    required this.text,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(height: 5)
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.textPrimary.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500
                )
              )
            ]
          )
        )
      ]
    );
  }
}

class _EvolutionNotesSection extends StatelessWidget {
  final String evolutionNotes;

  const _EvolutionNotesSection({
    required this.evolutionNotes,
  });

  @override
  Widget build(BuildContext context) {
    final sectionRadius = 10.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.tertiaryBackground,
        borderRadius: BorderRadius.circular(sectionRadius),
        border: Border.all(
          color: AppColors.secondaryButton.withValues(alpha: 0.25)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.fileMedical.data,
                size: 20,
                color: AppColors.secondary
              ),
              SizedBox(width: 10),
              Text(
                'Evolución clínica',
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
          SizedBox(height: 10),
          Text(
            evolutionNotes,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.textPrimary.withValues(alpha: 0.75),
              fontWeight: FontWeight.w500,
              height: 1.4
            )
          )
        ]
      )
    );
  }
}
