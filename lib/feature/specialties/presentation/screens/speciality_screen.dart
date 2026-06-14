import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecialityScreen extends StatelessWidget {
  const SpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Especialidades',
        backRoute: '/home',
      ),
      body: const SpecialityView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.reservedBottomSpace(context),
          right: 8,
        ),
        child: LabeledFloatingActionButton(
          label: 'Crear especialidad',
          heroTag: 'create-specialty-fab',
          onPressed: () => context.push('/create-specialty-screen'),
        ),
      ),
    );
  }
}
