import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SpecialityView extends ConsumerWidget {
  const SpecialityView({super.key});

  Future<void> _onMenuAction(
    BuildContext context,
    WidgetRef ref,
    Specialty specialty,
    SpecialityMenuAction action,
  ) async {
    switch (action) {
      case SpecialityMenuAction.update:
        context.push('/create-specialty-screen', extra: specialty);
      case SpecialityMenuAction.delete:
        await _confirmDelete(context, ref, specialty);
      case SpecialityMenuAction.disable:
        await _confirmStatusChange(context, ref, specialty, isActive: false);
      case SpecialityMenuAction.enable:
        await _confirmStatusChange(context, ref, specialty, isActive: true);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Specialty specialty,
  ) async {
    final confirmed = await DeleteSpecialityDialog.show(context, specialty);

    if (!confirmed || !context.mounted) return;

    final success = await ref
        .read(specialityProvider.notifier)
        .deleteSpecialty(specialty.id);

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Especialidad eliminada correctamente');
      return;
    }

    final errorMessage = ref.read(specialityProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  Future<void> _confirmStatusChange(
    BuildContext context,
    WidgetRef ref,
    Specialty specialty, {
    required bool isActive,
  }) async {
    final confirmed = isActive
        ? await DeactivateSpecialityDialog.showEnable(context, specialty)
        : await DeactivateSpecialityDialog.showDisable(context, specialty);

    if (!confirmed || !context.mounted) return;

    final success = await ref.read(specialityProvider.notifier).toggleSpecialtyStatus(
          specialty.id,
          SpecialityActive(isActive: isActive),
        );

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        isActive
            ? 'Especialidad habilitada correctamente'
            : 'Especialidad inhabilitada correctamente',
      );
      return;
    }

    final errorMessage = ref.read(specialityProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(specialityProvider);

    if (state.isLoading && state.specialties.isEmpty) {
      return const CustomLoadingWidget(
        message: 'Cargando especialidades...',
      );
    }

    if (state.errorMessage.isNotEmpty && state.specialties.isEmpty) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(specialityProvider.notifier).getSpecialties(),
      );
    }

    final activeSpecialties =
        state.specialties.where((specialty) => specialty.isActive).toList();
    final inactiveSpecialties =
        state.specialties.where((specialty) => !specialty.isActive).toList();

    if (state.specialties.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: () => ref.read(specialityProvider.notifier).getSpecialties(),
        isRefreshing: state.isLoading,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: 'No hay especialidades registradas',
              icon: FontAwesomeIcons.stethoscope.data,
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
                Tab(text: 'Habilitadas'),
                Tab(text: 'Inhabilitadas'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _SpecialityTabContent(
                  specialties: activeSpecialties,
                  emptyMessage: 'No hay especialidades habilitadas',
                  isRefreshing: state.isLoading,
                  onRefresh: () =>
                      ref.read(specialityProvider.notifier).getSpecialties(),
                  onMenuAction: (specialty, action) =>
                      _onMenuAction(context, ref, specialty, action),
                ),
                _SpecialityTabContent(
                  specialties: inactiveSpecialties,
                  emptyMessage: 'No hay especialidades inhabilitadas',
                  isRefreshing: state.isLoading,
                  onRefresh: () =>
                      ref.read(specialityProvider.notifier).getSpecialties(),
                  onMenuAction: (specialty, action) =>
                      _onMenuAction(context, ref, specialty, action),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialityTabContent extends StatelessWidget {
  final List<Specialty> specialties;
  final String emptyMessage;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;
  final void Function(Specialty specialty, SpecialityMenuAction action)?
      onMenuAction;

  const _SpecialityTabContent({
    required this.specialties,
    required this.emptyMessage,
    required this.isRefreshing,
    required this.onRefresh,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    if (specialties.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: onRefresh,
        isRefreshing: isRefreshing,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: emptyMessage,
              icon: FontAwesomeIcons.stethoscope.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

    return CustomRefreshableContent(
      onRefresh: onRefresh,
      isRefreshing: isRefreshing,
      child: SpecialtiesList(
        specialties: specialties,
        onMenuAction: onMenuAction,
      ),
    );
  }
}
