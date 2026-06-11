import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CreateAppointmentScreen extends StatelessWidget {
  const CreateAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Nueva cita',
        onBackPressed: () => context.pop(),
      ),
      body: const CreateAppointmentView(),
    );
  }
}
