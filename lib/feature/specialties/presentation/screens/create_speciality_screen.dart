import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CreateSpecialityScreen extends StatelessWidget {
  final Specialty? specialty;

  const CreateSpecialityScreen({
    super.key,
    this.specialty,
  });

  bool get _isEditing => specialty != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: _isEditing ? 'Editar especialidad' : 'Nueva especialidad',
        onBackPressed: () => context.pop(),
      ),
      body: CreateSpecialityView(specialty: specialty),
    );
  }
}
