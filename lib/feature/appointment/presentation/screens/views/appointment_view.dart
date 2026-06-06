import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> _onMenuAction(
    BuildContext context,
    AppointmentList appointment,
    AppointmentMenuAction action,
  ) async {
    switch (action) {
      case AppointmentMenuAction.updatePayment:
        await _updatePayment(context, appointment);
      case AppointmentMenuAction.cancel:
        await _cancelAppointment(context, appointment);
      case AppointmentMenuAction.confirm:
        await _confirmAppointment(context, appointment);
      case AppointmentMenuAction.reschedule:
        break;
    }
  }

  Future<void> _updatePayment(
    BuildContext context,
    AppointmentList appointment,
  ) async {
    final paymentData = await UpdatePaymentDialog.show(context, appointment);

    if (paymentData == null || !context.mounted) return;

    final success = await ref
        .read(appointmentProvider.notifier)
        .updateAppointmentStatus(
          appointment.id,
          AppointmentStatus(
            paymentStatus: UpdatePaymentData.paymentStatus,
            paymentMethod: paymentData.paymentMethod,
            amount: paymentData.amount,
            date: appointment.date,
            time: appointment.time,
          ),
        );

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Pago actualizado correctamente');
      return;
    }

    final errorMessage = ref.read(appointmentProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  Future<void> _confirmAppointment(
    BuildContext context,
    AppointmentList appointment,
  ) async {
    final confirmed =
        await ConfirmAppointmentDialog.show(context, appointment);

    if (!confirmed || !context.mounted) return;

    if (!AppointmentPaymentHelpers.canConfirmAppointment(appointment)) {
      AppSnackBar.error(
        context,
        'No se puede confirmar la cita. Falta registrar el pago.',
      );
      return;
    }

    final success = await ref
        .read(appointmentProvider.notifier)
        .updateAppointmentStatus(
          appointment.id,
          AppointmentStatus(
            status: 'CONFIRMED',
            date: appointment.date,
            time: appointment.time,
          ),
        );

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Cita confirmada correctamente');
      return;
    }

    final errorMessage = ref.read(appointmentProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  Future<void> _cancelAppointment(
    BuildContext context,
    AppointmentList appointment,
  ) async {
    final cancellationReason =
        await CancelAppointmentDialog.show(context, appointment);

    if (cancellationReason == null || !context.mounted) return;

    final success = await ref.read(appointmentProvider.notifier).cancelAppointment(
          appointment.id,
          AppointmentCancel(cancellationReason: cancellationReason),
        );

    if (!context.mounted) return;

    if (success) {
      AppSnackBar.success(context, 'Cita cancelada correctamente');
      return;
    }

    final errorMessage = ref.read(appointmentProvider).errorMessage;
    if (errorMessage.isNotEmpty) {
      AppSnackBar.error(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentProvider);

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
          16,
          8,
          16,
          CustomBottomNavigationBar.scrollBottomPadding(
            context,
            withFloatingActionButton: true,
          ),
        ),
        children: [
          AppointmentFilterBar(
            filter: state.filter,
            onFilterChanged: ref.read(appointmentProvider.notifier).updateFilter,
          ),
          if (state.isLoading && state.hasLoadedOnce)
            Padding(
              padding: EdgeInsets.only(top: 16),
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
          if (!state.isLoading)
            AppointmentListSection(
              appointments: state.appointments,
              onMenuAction: (appointment, action) =>
                  _onMenuAction(context, appointment, action),
            ),
        ],
      ),
    );
  }
}
