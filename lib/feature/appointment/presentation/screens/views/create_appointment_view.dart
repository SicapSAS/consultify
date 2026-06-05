import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class CreateAppointmentView extends StatelessWidget {
  const CreateAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.06,
        size.height * 0.03,
        size.width * 0.06,
        size.height * 0.04,
      ),
      child: const CreateAppointmentForm(),
    );
  }
}
