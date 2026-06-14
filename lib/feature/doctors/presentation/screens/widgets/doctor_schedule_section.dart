import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorScheduleSection extends StatelessWidget {
  final ShowSchedule schedule;

  const DoctorScheduleSection({
    super.key,
    required this.schedule,
  });

  static const _weekdayNames = {
    0: 'Domingo',
    1: 'Lunes',
    2: 'Martes',
    3: 'Miércoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo',
  };

  String _formatWorkDays(List<int> workDays) {
    if (workDays.isEmpty) return 'Sin días configurados';

    final labels = workDays
        .map((day) => _weekdayNames[day] ?? 'Día $day')
        .toList();

    return labels.join(', ');
  }

  String _formatTimeRange(String start, String end) {
    if (start == '00:00' && end == '00:00') return 'No configurado';
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10),
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
            children: [
              Icon(
                FontAwesomeIcons.calendarDays.data,
                size: 20,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 10),
              const Text(
                'Horario de atención',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _ScheduleInfoRow(
            icon: FontAwesomeIcons.clock.data,
            label: 'Duración de cita',
            text: '${schedule.appointmentDurationMinutes} minutos',
          ),
          _ScheduleInfoRow(
            icon: FontAwesomeIcons.calendarCheck.data,
            label: 'Días laborales',
            text: _formatWorkDays(schedule.workDays),
          ),
          _ScheduleInfoRow(
            icon: FontAwesomeIcons.sun.data,
            label: 'Jornada mañana',
            text: _formatTimeRange(
              schedule.workingHours.morning.start,
              schedule.workingHours.morning.end,
            ),
          ),
          _ScheduleInfoRow(
            icon: FontAwesomeIcons.moon.data,
            label: 'Jornada tarde',
            text: _formatTimeRange(
              schedule.workingHours.afternoon.start,
              schedule.workingHours.afternoon.end,
            ),
          ),
          _ScheduleInfoRow(
            icon: FontAwesomeIcons.penToSquare.data,
            label: 'Última actualización',
            text: schedule.updatedAtFormatted,
          ),
        ],
      ),
    );
  }
}

class _ScheduleInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String text;

  const _ScheduleInfoRow({
    required this.icon,
    required this.label,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textPrimary.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
