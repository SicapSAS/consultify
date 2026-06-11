import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DoctorsView extends ConsumerWidget {
  const DoctorsView({super.key});

  Future<void> _onMenuAction(
    BuildContext context,
    WidgetRef ref,
    Doctor doctor,
    DoctorMenuAction action,
  ) async {
    switch (action) {
      case DoctorMenuAction.update:
        context.push('/create-doctor-screen', extra: doctor);
      case DoctorMenuAction.delete:
        await _confirmDelete(context, ref, doctor);
      case DoctorMenuAction.disable:
        await _confirmStatusChange(context, ref, doctor, isActive: false);
      case DoctorMenuAction.enable:
        await _confirmStatusChange(context, ref, doctor, isActive: true);
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Doctor doctor,
  ) async {
    final confirmed = await DeleteDoctorDialog.show(context, doctor);

    if (!confirmed || !context.mounted) return;

    final success =
        await ref.read(doctorsProvider.notifier).deleteDoctor(doctor.id);

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Doctor eliminado correctamente');
      return;
    }

    final errorMessage = ref.read(doctorsProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  Future<void> _confirmStatusChange(
    BuildContext context,
    WidgetRef ref,
    Doctor doctor, {
    required bool isActive,
  }) async {
    final confirmed = isActive
        ? await DeactivateDoctorDialog.showEnable(context, doctor)
        : await DeactivateDoctorDialog.showDisable(context, doctor);

    if (!confirmed || !context.mounted) return;

    final success = await ref
        .read(doctorsProvider.notifier)
        .updateDoctorStatus(doctor.id, isActive);

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(
        context,
        isActive
            ? 'Doctor habilitado correctamente'
            : 'Doctor inhabilitado correctamente',
      );
      return;
    }

    final errorMessage = ref.read(doctorsProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorsProvider);

    if (state.isLoading && state.doctors.isEmpty) {
      return const CustomLoadingWidget(
        message: 'Cargando doctores...',
      );
    }

    if (state.errorMessage.isNotEmpty && state.doctors.isEmpty) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(doctorsProvider.notifier).getDoctors(),
      );
    }

    final activeDoctors =
        state.doctors.where((doctor) => doctor.isActive).toList();
    final inactiveDoctors =
        state.doctors.where((doctor) => !doctor.isActive).toList();

    if (state.doctors.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: () => ref.read(doctorsProvider.notifier).getDoctors(),
        isRefreshing: state.isLoading,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: 'No hay doctores registrados',
              icon: FontAwesomeIcons.userDoctor.data,
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
                Tab(text: 'Habilitados'),
                Tab(text: 'Inhabilitados'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _DoctorTabContent(
                  doctors: activeDoctors,
                  emptyMessage: 'No hay doctores habilitados',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(doctorsProvider.notifier).getDoctors(),
                  onMenuAction: (doctor, action) =>
                      _onMenuAction(context, ref, doctor, action),
                ),
                _DoctorTabContent(
                  doctors: inactiveDoctors,
                  emptyMessage: 'No hay doctores inhabilitados',
                  isRefreshing: state.isLoading,
                  onRefresh: () => ref.read(doctorsProvider.notifier).getDoctors(),
                  onMenuAction: (doctor, action) =>
                      _onMenuAction(context, ref, doctor, action),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorTabContent extends StatelessWidget {
  final List<Doctor> doctors;
  final String emptyMessage;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;
  final void Function(Doctor doctor, DoctorMenuAction action)? onMenuAction;

  const _DoctorTabContent({
    required this.doctors,
    required this.emptyMessage,
    required this.isRefreshing,
    required this.onRefresh,
    this.onMenuAction,
  });

  @override
  Widget build(BuildContext context) {
    if (doctors.isEmpty) {
      return CustomRefreshableContent(
        onRefresh: onRefresh,
        isRefreshing: isRefreshing,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            CustomEmptyStateWidget(
              message: emptyMessage,
              icon: FontAwesomeIcons.userDoctor.data,
              iconColor: AppColors.secondary.withValues(alpha: 0.5),
            ),
          ],
        ),
      );
    }

    return CustomRefreshableContent(
      onRefresh: onRefresh,
      isRefreshing: isRefreshing,
      child: DoctorList(
        doctors: doctors,
        onMenuAction: onMenuAction,
      ),
    );
  }
}
