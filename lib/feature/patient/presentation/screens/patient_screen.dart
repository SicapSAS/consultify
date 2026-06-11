import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: const CustomAppBar(
        title: 'Pacientes',
        openDrawer: true,
      ),
      body: const PatientView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.reservedBottomSpace(context),
          right: 8,
        ),
        child: LabeledFloatingActionButton(
          label: 'Crear paciente',
          heroTag: 'create-patient-fab',
          onPressed: () => context.push('/create-patient-screen'),
        ),
      ),
    );
  }
}