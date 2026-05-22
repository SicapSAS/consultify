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
    final radius = AppDimens.smallBorderRadius(0.02, context);
    final rowGap = AppDimens.heightPercentage(0.006, context);
    final cardPadding = AppDimens.widthPercentage(0.04, context);

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
                    fontSize: AppDimens.subtitleText(context),
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
            SizedBox(height: AppDimens.heightPercentage(0.012, context)),
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
          size: AppDimens.tinyIcon(context),
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
        SizedBox(width: AppDimens.widthPercentage(0.02, context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: AppDimens.tinyText(context),
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(height: AppDimens.heightPercentage(0.002, context))
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: AppDimens.littleText(context),
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
    final sectionRadius = AppDimens.smallBorderRadius(0.015, context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.widthPercentage(0.03, context)),
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
                size: AppDimens.tinyIcon(context),
                color: AppColors.secondary
              ),
              SizedBox(width: AppDimens.widthPercentage(0.02, context)),
              Text(
                'Evolución clínica',
                style: TextStyle(
                  fontSize: AppDimens.littleText(context),
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700
                )
              )
            ]
          ),
          SizedBox(height: AppDimens.heightPercentage(0.008, context)),
          Text(
            evolutionNotes,
            style: TextStyle(
              fontSize: AppDimens.littleText(context),
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
