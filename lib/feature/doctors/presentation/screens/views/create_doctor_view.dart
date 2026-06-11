import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateDoctorView extends StatelessWidget {
  const CreateDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormScrollView(
      child: CreateDoctorForm(),
    );
  }
}
