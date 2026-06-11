import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentDetailView extends ConsumerStatefulWidget {
  final String appointmentId;

  const AppointmentDetailView({
    super.key,
    required this.appointmentId,
  });

  @override
  ConsumerState<AppointmentDetailView> createState() =>
      _AppointmentDetailViewState();
}

class _AppointmentDetailViewState extends ConsumerState<AppointmentDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(appointmentProvider.notifier)
          .getAppointmentById(widget.appointmentId);
    });
  }

  bool _isCurrentAppointment(AppointmentShow? appointment) {
    return appointment?.id == widget.appointmentId;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentProvider);
    final appointment = state.selectedAppointment;
    final hasCurrentAppointment = _isCurrentAppointment(appointment);

    if (state.isLoading && !hasCurrentAppointment) {
      return const CustomLoadingWidget(
        message: 'Cargando detalle de la cita...',
      );
    }

    if (state.errorMessage.isNotEmpty && !hasCurrentAppointment) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref
            .read(appointmentProvider.notifier)
            .getAppointmentById(widget.appointmentId),
      );
    }

    if (!hasCurrentAppointment || appointment == null) {
      return CustomEmptyStateWidget(
        message: 'No se encontró información de la cita',
        icon: FontAwesomeIcons.calendarXmark.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref
          .read(appointmentProvider.notifier)
          .getAppointmentById(widget.appointmentId),
      isRefreshing: state.isLoading,
      child: AppointmentDetailBody(appointment: appointment),
    );
  }
}
