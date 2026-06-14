import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.12),
        CustomEmptyStateWidget(
          message:
              'Configura el horario de atención de cada profesional.\n\n'
              'Define días laborales, jornadas de mañana y tarde, '
              'y la duración de cada cita.',
          icon: FontAwesomeIcons.calendarDays.data,
          iconColor: AppColors.secondary.withValues(alpha: 0.5),
        ),
      ],
    );
  }
}
