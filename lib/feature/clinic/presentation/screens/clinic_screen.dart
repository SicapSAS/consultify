import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Clínicas',
        backRoute: '/home',
      ),
      body: const ClinicView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.reservedBottomSpace(context),
          right: 8,
        ),
        child: LabeledFloatingActionButton(
          label: 'Crear clínica',
          heroTag: 'create-clinic-fab',
          onPressed: () => context.push('/create-clinic-screen')
        )
      )
    );
  }
}