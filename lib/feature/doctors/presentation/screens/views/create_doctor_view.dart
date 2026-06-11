import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateDoctorView extends StatelessWidget {
  const CreateDoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16,
      ),
      child: const CreateDoctorForm(),
    );
  }
}
