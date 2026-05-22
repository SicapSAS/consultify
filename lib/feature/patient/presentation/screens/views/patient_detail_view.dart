import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientDetailView extends ConsumerStatefulWidget {
  final String patientId;

  const PatientDetailView({
    super.key,
    required this.patientId,
  });

  @override
  ConsumerState<PatientDetailView> createState() => _PatientDetailViewState();
}

class _PatientDetailViewState extends ConsumerState<PatientDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(patientProvider.notifier).getPatientShow(widget.patientId);
    });
  }

  bool _isCurrentPatient(PatientShow? history) {
    return history?.patient.id == widget.patientId;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(patientProvider);
    final history = state.history;
    final hasCurrentHistory = _isCurrentPatient(history);

    if (state.isLoading && !hasCurrentHistory) {
      return const CustomLoadingWidget(
        message: 'Cargando historial...',
      );
    }

    if (state.errorMessage.isNotEmpty && !hasCurrentHistory) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref
            .read(patientProvider.notifier)
            .getPatientShow(widget.patientId),
      );
    }

    if (!hasCurrentHistory || history == null) {
      return CustomEmptyStateWidget(
        message: 'No se encontró información del paciente',
        icon: FontAwesomeIcons.user.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () =>
          ref.read(patientProvider.notifier).getPatientShow(widget.patientId),
      isRefreshing: state.isLoading,
      child: PatientDetailBody(history: history)
    );
  }
}
