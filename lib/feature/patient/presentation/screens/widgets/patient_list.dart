import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  final List<Patient> patients;
  final void Function(Patient patient)? onPatientTap;

  const PatientList({
    super.key,
    required this.patients,
    this.onPatientTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.02, context),
        AppDimens.widthPercentage(0.04, context),
        AppDimens.heightPercentage(0.04, context)
      ),
      itemCount: patients.length,
      separatorBuilder: (context, _) => SizedBox(
        height: AppDimens.heightPercentage(0.015, context),
      ),
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListTile(
          patient: patient,
          onTap: onPatientTap != null ? () => onPatientTap!(patient) : null
        );
      }
    );
  }
}
