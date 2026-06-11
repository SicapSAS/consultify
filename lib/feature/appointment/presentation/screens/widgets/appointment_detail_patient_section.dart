import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentDetailPatientSection extends StatelessWidget {
  final PatientId patient;

  const AppointmentDetailPatientSection({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      AppointmentDetailInfoRow(
        icon: FontAwesomeIcons.user.data,
        text: patient.name,
      ),
    ];

    if (AppointmentDetailHelpers.hasText(patient.documentId)) {
      rows.add(
        AppointmentDetailInfoRow(
          icon: FontAwesomeIcons.idCard.data,
          text: '${patient.documentType} · ${patient.documentId}',
        ),
      );
    }

    if (AppointmentDetailHelpers.hasText(patient.email)) {
      rows.add(
        AppointmentDetailInfoRow(
          icon: FontAwesomeIcons.envelope.data,
          text: patient.email,
        ),
      );
    }

    if (AppointmentDetailHelpers.hasText(patient.phone)) {
      rows.add(
        AppointmentDetailInfoRow(
          icon: FontAwesomeIcons.phone.data,
          text: patient.phone,
        ),
      );
    }

    return AppointmentDetailSectionCard(
      title: 'Paciente',
      icon: FontAwesomeIcons.user.data,
      children: rows,
    );
  }
}
