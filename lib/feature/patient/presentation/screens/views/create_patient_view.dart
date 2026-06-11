import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreatePatientView extends StatelessWidget {
  final Patient? patient;

  const CreatePatientView({
    super.key,
    this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return FormScrollView(
      child: CreatePatientForm(patient: patient),
    );
  }
}
