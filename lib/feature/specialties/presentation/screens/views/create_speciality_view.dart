import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateSpecialityView extends StatelessWidget {
  final Specialty? specialty;

  const CreateSpecialityView({
    super.key,
    this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return FormScrollView(
      child: CreateSpecialityForm(specialty: specialty),
    );
  }
}
