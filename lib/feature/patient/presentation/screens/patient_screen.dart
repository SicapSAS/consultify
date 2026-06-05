import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Pacientes',
        backRoute: '/home',
      ),
      body: const PatientView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: size.height * 0.02,
          right: size.width * 0.02,
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