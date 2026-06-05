import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentListTile extends StatelessWidget {
  final AppointmentList appointment;
  final VoidCallback? onTap;

  const AppointmentListTile({
    super.key,
    required this.appointment,
    this.onTap,
  });

  String _formatSchedule(AppointmentList appointment) {
    final day = appointment.date.day.toString().padLeft(2, '0');
    final month = appointment.date.month.toString().padLeft(2, '0');
    final year = appointment.date.year;

    final hasTime = appointment.time.trim().isNotEmpty;
    final hasEndTime = appointment.endTime.trim().isNotEmpty;

    if (hasTime && hasEndTime) {
      return '$day/$month/$year · ${appointment.time} - ${appointment.endTime}';
    }

    if (hasTime) {
      return '$day/$month/$year · ${appointment.time}';
    }

    return '$day/$month/$year';
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
      case 'ATTENDED':
        return AppColors.successBackground;
      case 'NOT_ATTENDED':
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.02;
    final rowGap = size.height * 0.006;
    final cardPadding = size.width * 0.04;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
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
                      _formatSchedule(appointment),
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  StatusBadge(
                    label: _statusLabel(appointment.status),
                    accentColor: _statusColor(appointment.status),
                  ),
                ],
              ),
              SizedBox(height: rowGap),
              _AppointmentInfoRow(
                icon: FontAwesomeIcons.user.data,
                text: appointment.patientId.name,
              ),
              SizedBox(height: rowGap),
              _AppointmentInfoRow(
                icon: FontAwesomeIcons.userDoctor.data,
                text: appointment.professionalId.name,
              ),
              SizedBox(height: rowGap),
              _AppointmentInfoRow(
                icon: FontAwesomeIcons.moneyBill.data,
                text: _paymentLabel(appointment.paymentStatus),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppointmentInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AppointmentInfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.textPrimary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary.withValues(alpha: 0.75),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
