import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CreatePatientScreen extends StatelessWidget {
  final Patient? patient;

  const CreatePatientScreen({
    super.key,
    this.patient,
  });

  bool get _isEditing => patient != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: _isEditing ? 'Actualizar paciente' : 'Nuevo paciente',
        onBackPressed: () => context.pop(),
      ),
      body: CreatePatientView(patient: patient),
    );
  }
}
