import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateClinicView extends StatelessWidget {
  const CreateClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormScrollView(
      child: CreateClinicForm(),
    );
  }
}
