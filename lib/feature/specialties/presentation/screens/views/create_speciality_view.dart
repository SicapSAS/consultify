import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateSpecialityView extends StatelessWidget {
  const CreateSpecialityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormScrollView(
      child: CreateSpecialityForm(),
    );
  }
}
