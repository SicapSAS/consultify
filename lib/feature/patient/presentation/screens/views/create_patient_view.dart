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
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16,
      ),
      child: CreatePatientForm(patient: patient),
    );
  }
}
