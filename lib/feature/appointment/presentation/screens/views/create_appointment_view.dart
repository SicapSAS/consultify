import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateAppointmentView extends StatelessWidget {
  const CreateAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormScrollView(
      child: CreateAppointmentForm(),
    );
  }
}
