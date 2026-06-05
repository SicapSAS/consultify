import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientView extends ConsumerWidget {
  const PatientView({super.key});

  Future<void> _onMenuAction(
    BuildContext context,
    WidgetRef ref,
    Patient patient,
    PatientMenuAction action,
  ) async {
    switch (action) {
      case PatientMenuAction.update:
        context.push('/create-patient-screen', extra: patient);
      case PatientMenuAction.disable:
        await _confirmStatusChange(context, ref, patient, isActive: false);
      case PatientMenuAction.enable:
        await _confirmStatusChange(context, ref, patient, isActive: true);
    }
  }

  Future<void> _confirmStatusChange(
    BuildContext context,
    WidgetRef ref,
    Patient patient, {
    required bool isActive,
  }) async {
    final confirmed = isActive
        ? await DeactivatePatientDialog.showEnable(context, patient)
        : await DeactivatePatientDialog.showDisable(context, patient);

    if (!confirmed || !context.mounted) return;

    final success = await ref
        .read(patientProvider.notifier)
        .updatePatientStatus(patient.id, isActive);

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        isActive
            ? 'Paciente habilitado correctamente'
            : 'Paciente inhabilitado correctamente',
      );
      return;
    }

    final errorMessage = ref.read(patientProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

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
        patients: state.patients,
        onPatientTap: (patient) => context.push('/patient-screen/${patient.id}'),
        onMenuAction: (patient, action) => _onMenuAction(context, ref, patient, action),
      ),
    );
  }
}
