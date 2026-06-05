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
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.06,
        size.height * 0.03,
        size.width * 0.06,
        size.height * 0.04,
      ),
      child: CreatePatientForm(patient: patient),
    );
  }
}
