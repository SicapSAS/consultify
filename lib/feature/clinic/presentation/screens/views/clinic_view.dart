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

    final success =
        await ref.read(clinicProvider.notifier).deactivateClinic(clinic.id);

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

    final activeClinics =
        state.clinics.where((clinic) => clinic.isActive).toList();
    final inactiveClinics =
        state.clinics.where((clinic) => !clinic.isActive).toList();

    if (state.clinics.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: () => ref.read(clinicProvider.notifier).getClinics(),
        isRefreshing: state.isLoading,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: 'No hay clínicas registradas',
              icon: FontAwesomeIcons.hospital.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

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
                Tab(text: 'Activas'),
                Tab(text: 'Inactivas'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _ClinicTabContent(
                  clinics: activeClinics,
                  emptyMessage: 'No hay clínicas activas',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(clinicProvider.notifier).getClinics(),
                  onMenuAction: (clinic, action) =>
                      _onMenuAction(context, ref, clinic, action),
                ),
                _ClinicTabContent(
                  clinics: inactiveClinics,
                  emptyMessage: 'No hay clínicas inactivas',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(clinicProvider.notifier).getClinics(),
                  onMenuAction: (clinic, action) =>
                      _onMenuAction(context, ref, clinic, action),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicTabContent extends StatelessWidget {
  final List<ListClinic> clinics;
  final String emptyMessage;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;
  final void Function(ListClinic clinic, ClinicMenuAction action)? onMenuAction;

  const _ClinicTabContent({
    required this.clinics,
    required this.emptyMessage,
    required this.isRefreshing,
    required this.onRefresh,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    if (clinics.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: onRefresh,
        isRefreshing: isRefreshing,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: emptyMessage,
              icon: FontAwesomeIcons.hospital.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

    return CustomRefreshableContent(
      onRefresh: onRefresh,
      isRefreshing: isRefreshing,
      child: ClinicList(
        clinics: clinics,
        onMenuAction: onMenuAction,
      ),
    );
  }
}
