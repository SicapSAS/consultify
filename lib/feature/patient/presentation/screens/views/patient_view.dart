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

    final activePatients =
        state.patients.where((patient) => patient.isActive).toList();
    final inactivePatients =
        state.patients.where((patient) => !patient.isActive).toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: AppColors.secondaryBackground,
            child: TabBar(
              labelColor: AppColors.secondary,
              unselectedLabelColor: AppColors.secondary.withValues(alpha: 0.5),
              indicatorColor: AppColors.secondaryButton,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              tabs: const [
                Tab(text: 'Habilitados'),
                Tab(text: 'Inhabilitados'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _PatientTabContent(
                  patients: activePatients,
                  emptyMessage: 'No hay pacientes habilitados',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(patientProvider.notifier).getPatients(),
                  onPatientTap: (patient) =>
                      context.push('/patient-screen/${patient.id}'),
                  onMenuAction: (patient, action) =>
                      _onMenuAction(context, ref, patient, action),
                ),
                _PatientTabContent(
                  patients: inactivePatients,
                  emptyMessage: 'No hay pacientes inhabilitados',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(patientProvider.notifier).getPatients(),
                  onPatientTap: (patient) =>
                      context.push('/patient-screen/${patient.id}'),
                  onMenuAction: (patient, action) =>
                      _onMenuAction(context, ref, patient, action),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientTabContent extends StatelessWidget {
  final List<Patient> patients;
  final String emptyMessage;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;
  final void Function(Patient patient)? onPatientTap;
  final void Function(Patient patient, PatientMenuAction action)? onMenuAction;

  const _PatientTabContent({
    required this.patients,
    required this.emptyMessage,
    required this.isRefreshing,
    required this.onRefresh,
    this.onPatientTap,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    if (patients.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: onRefresh,
        isRefreshing: isRefreshing,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: emptyMessage,
              icon: FontAwesomeIcons.user.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

    return CustomRefreshableContent(
      onRefresh: onRefresh,
      isRefreshing: isRefreshing,
      child: PatientList(
        patients: patients,
        onPatientTap: onPatientTap,
        onMenuAction: onMenuAction,
      ),
    );
  }
}
