import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentDetailHeader extends StatelessWidget {
  final AppointmentShow appointment;

  const AppointmentDetailHeader({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  AppointmentDetailHelpers.formatSchedule(appointment),
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              StatusBadge(
                label: AppointmentDetailHelpers.statusLabel(appointment.status),
                accentColor:
                    AppointmentDetailHelpers.statusColor(appointment.status),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
