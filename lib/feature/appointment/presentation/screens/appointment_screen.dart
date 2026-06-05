import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';



class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Citas Registradas',
        backRoute: '/home',
      ),
      body: AppointmentView(),
      floatingActionButton: LabeledFloatingActionButton(
        label: 'Nueva Cita',
        heroTag: 'create-appointment-fab',
        onPressed: () => context.push('/create-appointment-screen'),
      ),
    );
  }
}