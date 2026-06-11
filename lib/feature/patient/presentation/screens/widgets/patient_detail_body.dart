import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientDetailBody extends StatelessWidget {
  final PatientShow history;

  const PatientDetailBody({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16
      ),
      children: [
        PatientDetailHeader(
          patient: history.patient,
          totalAppointments: history.total
        ),
        SizedBox(height: 16),
        PatientAppointmentsSection(history: history),
      ]
    );
  }
}
