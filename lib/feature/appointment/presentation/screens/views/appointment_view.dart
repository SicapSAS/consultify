import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentView extends ConsumerStatefulWidget {
  const AppointmentView({super.key});

  @override
  ConsumerState<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends ConsumerState<AppointmentView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appointmentProvider.notifier).getAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentProvider);
    final size = MediaQuery.of(context).size;

    if (state.isLoading && !state.hasLoadedOnce) {
      return const CustomLoadingWidget(
        message: 'Cargando citas...',
      );
    }

    if (state.errorMessage.isNotEmpty && !state.hasLoadedOnce) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(appointmentProvider.notifier).getAppointments(),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(appointmentProvider.notifier).getAppointments(),
      isRefreshing: state.isLoading,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          size.width * 0.04,
          size.height * 0.02,
          size.width * 0.04,
          size.height * 0.12,
        ),
        children: [
          AppointmentFilterBar(
            filter: state.filter,
            onFilterChanged: ref.read(appointmentProvider.notifier).updateFilter,
          ),
          if (state.isLoading && state.hasLoadedOnce)
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.secondaryButton,
                  ),
                ),
              ),
            ),
          if (!state.isLoading && state.appointments.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.06),
              child: CustomEmptyStateWidget(
                message: state.filter.emptyMessage,
                icon: FontAwesomeIcons.calendarDays.data,
                iconColor: AppColors.secondary.withValues(alpha: 0.5),
              ),
            )
          else if (!state.isLoading)
            AppointmentListWidget(
              appointments: state.appointments,
            ),
        ],
      ),
    );
  }
}
