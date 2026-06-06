import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateClinicView extends StatelessWidget {
  const CreateClinicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        16,
      ),
      child: CreateClinicForm()
    );
  }
}
