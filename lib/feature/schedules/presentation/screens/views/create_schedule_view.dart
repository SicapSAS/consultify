import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateScheduleView extends StatelessWidget {
  final Doctor? doctor;

  const CreateScheduleView({
    super.key,
    this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return FormScrollView(
      child: CreateScheduleForm(doctor: doctor),
    );
  }
}
