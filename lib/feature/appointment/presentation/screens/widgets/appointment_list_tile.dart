import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentListTile extends StatelessWidget {
  final AppointmentList appointment;
  final VoidCallback? onTap;
  final ValueChanged<AppointmentMenuAction>? onMenuAction;

  const AppointmentListTile({
    super.key,
    required this.appointment,
    this.onTap,
    this.onMenuAction,
  });

  bool _isPaymentCompleted() {
    return AppointmentPaymentHelpers.isPaymentCompleted(appointment.paymentStatus);
  }

  bool _canConfirmAppointment() {
    final status = appointment.status.toUpperCase();
    return status != 'CONFIRMED' &&
        status != 'ATTENDED' &&
        status != 'COMPLETED' &&
        status != 'CANCELLED';
  }

  List<ContextMenuItem<AppointmentMenuAction>> _buildMenuItems() {
    final items = <ContextMenuItem<AppointmentMenuAction>>[];

    if (!_isPaymentCompleted()) {
      items.add(
        const ContextMenuItem<AppointmentMenuAction>(
          value: AppointmentMenuAction.updatePayment,
          label: 'Actualizar pago',
          icon: Icons.payments_outlined,
        ),
      );
    }

    if (appointment.status.toUpperCase() != 'CANCELLED') {
      items.add(
        const ContextMenuItem<AppointmentMenuAction>(
          value: AppointmentMenuAction.reschedule,
          label: 'Reagendar',
          icon: Icons.calendar_month_outlined,
        ),
      );
    }

    if (_canConfirmAppointment()) {
      items.add(
        const ContextMenuItem<AppointmentMenuAction>(
          value: AppointmentMenuAction.confirm,
          label: 'Confirmar cita',
          icon: Icons.check_circle_outline,
        ),
      );
    }

    if (appointment.status.toUpperCase() != 'CANCELLED') {
      items.add(
        const ContextMenuItem<AppointmentMenuAction>(
          value: AppointmentMenuAction.cancel,
          label: 'Cancelar cita',
          icon: Icons.cancel_outlined,
          isDestructive: true,
        ),
      );
    }

    return items;
  }

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
    final radius = 12.0;
    final rowGap = 8.0;
    final cardPadding = 16.0;
    final menuIconSize = 20.0;

    return Material(
      color: Colors.transparent,
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                cardPadding,
                cardPadding,
                cardPadding + menuIconSize + 4,
                cardPadding,
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
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
                              fontSize: 17,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
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
            Positioned(
              top: 0,
              bottom: 0,
              right: 6,
              child: Center(
                child: ContextMenuButton<AppointmentMenuAction>(
                  items: _buildMenuItems(),
                  onSelected: onMenuAction,
                  iconColor: AppColors.iconDark,
                  iconSize: menuIconSize,
                  padding: const EdgeInsets.all(5),
                ),
              ),
            ),
          ],
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
