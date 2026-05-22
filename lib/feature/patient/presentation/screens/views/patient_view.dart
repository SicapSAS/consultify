import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientView extends ConsumerWidget {
  const PatientView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientProvider);

    if (state.isLoading && state.patients.isEmpty) {
      return const CustomLoadingWidget(
        message: 'Cargando pacientes...',
      );
    }

    if (state.errorMessage.isNotEmpty && state.patients.isEmpty) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(patientProvider.notifier).getPatients(),
      );
    }

    if (state.patients.isEmpty) {
      return CustomEmptyStateWidget(
        message: 'No hay pacientes registrados',
        icon: FontAwesomeIcons.user.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(patientProvider.notifier).getPatients(),
      isRefreshing: state.isLoading,
      child: PatientList(
        patients: state.patients
      )
    );
  }
}
