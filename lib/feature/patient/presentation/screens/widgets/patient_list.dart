import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientList extends StatelessWidget {
  final List<Patient> patients;
  final void Function(Patient patient)? onPatientTap;
  final void Function(Patient patient, PatientMenuAction action)? onMenuAction;

  const PatientList({
    super.key,
    required this.patients,
    this.onPatientTap,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        size.height * 0.04
      ),
      itemCount: patients.length,
      separatorBuilder: (context, _) => SizedBox(
        height: size.height * 0.015,
      ),
      itemBuilder: (context, index) {
        final patient = patients[index];
        return PatientListTile(
          patient: patient,
          onTap: onPatientTap != null ? () => onPatientTap!(patient) : null,
          onMenuAction: onMenuAction != null
              ? (action) => onMenuAction!(patient, action)
              : null,
        );
      }
    );
  }
}
