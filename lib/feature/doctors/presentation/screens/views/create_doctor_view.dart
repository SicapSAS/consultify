import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateDoctorView extends StatelessWidget {
  final Doctor? doctor;

  const CreateDoctorView({
    super.key,
    this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return FormScrollView(
      child: CreateDoctorForm(doctor: doctor),
    );
  }
}
