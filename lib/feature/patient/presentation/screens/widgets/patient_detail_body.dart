import 'package:consultify/config/config.dart';
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
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.02, context),
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.04, context)
      ),
      children: [
        PatientDetailHeader(
          patient: history.patient,
          totalAppointments: history.total
        ),
        SizedBox(height: AppDimens.heightPercentage(0.02, context)),
        PatientAppointmentSection(
          title: 'Próximas citas',
          appointments: history.upcoming,
          emptyMessage: 'No hay citas próximas'
        ),
        SizedBox(height: AppDimens.heightPercentage(0.02, context)),
        PatientAppointmentSection(
          title: 'Historial de citas',
          appointments: history.past,
          emptyMessage: 'No hay citas anteriores'
        )
      ]
    );
  }
}
