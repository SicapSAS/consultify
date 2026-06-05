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
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        size.height * 0.04
      ),
      children: [
        PatientDetailHeader(
          patient: history.patient,
          totalAppointments: history.total
        ),
        SizedBox(height: size.height * 0.02),
        PatientAppointmentSection(
          title: 'Próximas citas',
          appointments: history.upcoming,
          emptyMessage: 'No hay citas próximas'
        ),
        SizedBox(height: size.height * 0.02),
        PatientAppointmentSection(
          title: 'Historial de citas',
          appointments: history.past,
          emptyMessage: 'No hay citas anteriores'
        )
      ]
    );
  }
}
