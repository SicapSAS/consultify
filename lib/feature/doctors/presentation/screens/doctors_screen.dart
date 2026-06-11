import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Doctores',
        backRoute: '/home',
      ),
      body: const DoctorsView(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: CustomBottomNavigationBar.reservedBottomSpace(context),
          right: 4,
        ),
        child: LabeledFloatingActionButton(
          label: 'Crear doctor',
          heroTag: 'create-doctor-fab',
          onPressed: () => context.push('/create-doctor-screen'),
        ),
      ),
    );
  }
}