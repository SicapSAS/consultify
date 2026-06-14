import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SchedulesScreen extends StatelessWidget {
  const SchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Horarios',
        backRoute: '/home',
      ),
      body: const SchedulesView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.reservedBottomSpace(context),
          right: 8,
        ),
        child: LabeledFloatingActionButton(
          label: 'Configurar horario',
          heroTag: 'create-schedule-fab',
          onPressed: () => context.push('/create-schedule-screen'),
        ),
      ),
    );
  }
}
