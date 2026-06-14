import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScheduleTimeBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? startTime;
  final String? endTime;
  final VoidCallback? onPickStart;
  final VoidCallback? onPickEnd;

  const ScheduleTimeBlock({
    super.key,
    required this.title,
    required this.icon,
    required this.startTime,
    required this.endTime,
    required this.onPickStart,
    required this.onPickEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.secondary),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: AppointmentPickerField(
                label: startTime ?? 'Inicio',
                icon: FontAwesomeIcons.clock.data,
                onTap: onPickStart,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppointmentPickerField(
                label: endTime ?? 'Fin',
                icon: FontAwesomeIcons.clock.data,
                onTap: onPickEnd,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
