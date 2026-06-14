import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CreateSpecialityScreen extends StatelessWidget {
  const CreateSpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Nueva especialidad',
        onBackPressed: () => context.pop(),
      ),
      body: const CreateSpecialityView(),
    );
  }
}
