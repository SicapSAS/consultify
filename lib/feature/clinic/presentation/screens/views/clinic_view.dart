import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicView extends ConsumerWidget {
  const ClinicView({super.key});

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
        onRetry: () => ref.read(clinicProvider.notifier).getClinics()
      );
    }

    if (state.clinics.isEmpty) {
      return CustomEmptyStateWidget(
        message: 'No hay clínicas registradas',
        icon: FontAwesomeIcons.hospital.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5)
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(clinicProvider.notifier).getClinics(),
      isRefreshing: state.isLoading,
      child: ClinicList(clinics: state.clinics)
    );
  }
}
