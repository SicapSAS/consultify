import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentDetailProfessionalSection extends StatelessWidget {
  final ProfessionalId professional;
  final int durationMinutes;

  const AppointmentDetailProfessionalSection({
    super.key,
    required this.professional,
    required this.durationMinutes,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      AppointmentDetailInfoRow(
        icon: FontAwesomeIcons.userDoctor.data,
        text: professional.name,
      ),
    ];

    if (AppointmentDetailHelpers.hasText(professional.specialty)) {
      rows.add(
        AppointmentDetailInfoRow(
          icon: FontAwesomeIcons.stethoscope.data,
          text: professional.specialty,
        ),
      );
    }

    rows.add(
      AppointmentDetailInfoRow(
        icon: FontAwesomeIcons.clock.data,
        text: '$durationMinutes min',
      ),
    );

    return AppointmentDetailSectionCard(
      title: 'Profesional',
      icon: FontAwesomeIcons.userDoctor.data,
      children: rows,
    );
  }
}
