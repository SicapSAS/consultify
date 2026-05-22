import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicView extends ConsumerWidget {
  const ClinicView({super.key});

  Future<void> _onMenuAction(
    BuildContext context,
    WidgetRef ref,
    ListClinic clinic,
    ClinicMenuAction action,
  ) async {
    switch (action) {
      case ClinicMenuAction.disable:
        await _confirmDeactivate(context, ref, clinic);
      case ClinicMenuAction.update:
        break;
    }
  }

  Future<void> _confirmDeactivate(
    BuildContext context,
    WidgetRef ref,
    ListClinic clinic,
  ) async {
    final confirmed = await DeactivateClinicDialog.show(context, clinic);

    if (!confirmed || !context.mounted) return;

    final success = await ref.read(clinicProvider.notifier).deactivateClinic(clinic.id);

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Clínica inhabilitada correctamente');
      return;
    }

    final errorMessage = ref.read(clinicProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(clinicProvider);

    if (state.isLoading && state.clinics.isEmpty) {
      return const CustomLoadingWidget(
        message: 'Cargando clínicas...',
      );
    }

    if (state.errorMessage.isNotEmpty && state.clinics.isEmpty) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(clinicProvider.notifier).getClinics(),
      );
    }

    if (state.clinics.isEmpty) {
      return CustomEmptyStateWidget(
        message: 'No hay clínicas registradas',
        icon: FontAwesomeIcons.hospital.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(clinicProvider.notifier).getClinics(),
      isRefreshing: state.isLoading,
      child: ClinicList(
        clinics: state.clinics,
        onMenuAction: (clinic, action) => _onMenuAction(context, ref, clinic, action),
      ),
    );
  }
}
