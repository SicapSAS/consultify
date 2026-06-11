import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CreateDoctorScreen extends StatelessWidget {
  final Doctor? doctor;

  const CreateDoctorScreen({
    super.key,
    this.doctor,
  });

  bool get _isEditing => doctor != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: _isEditing ? 'Actualizar doctor' : 'Nuevo doctor',
        onBackPressed: () => context.pop(),
      ),
      body: CreateDoctorView(doctor: doctor),
    );
  }
}
