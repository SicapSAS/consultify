import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateScheduleScreen extends StatelessWidget {
  final Doctor? doctor;

  const CreateScheduleScreen({
    super.key,
    this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Configurar horario',
        onBackPressed: () => context.pop(),
      ),
      body: CreateScheduleView(doctor: doctor),
    );
  }
}
