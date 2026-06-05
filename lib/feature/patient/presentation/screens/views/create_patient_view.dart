import 'package:consultify/config/config.dart';
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
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.03, context),
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.04, context),
      ),
      child: CreatePatientForm(patient: patient),
    );
  }
}
