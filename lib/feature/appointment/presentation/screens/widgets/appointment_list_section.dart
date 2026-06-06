import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentListSection extends StatelessWidget {
  final List<AppointmentList> appointments;

  const AppointmentListSection({
    super.key,
    required this.appointments,
  });

  static bool matchesTab(AppointmentList appointment, int tabIndex) {
    final status = appointment.status.toUpperCase();

    switch (tabIndex) {
      case 0:
        return status == 'CONFIRMED' ||
            status == 'ATTENDED' ||
            status == 'COMPLETED';
      case 1:
        return status == 'PENDING';
      case 2:
        return status == 'NOT_ATTENDED' || status == 'CANCELLED';
      default:
        return false;
    }
  }

  static String emptyMessageForTab(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return 'No hay citas confirmadas';
      case 1:
        return 'No hay citas pendientes';
      case 2:
        return 'No hay citas no atendidas';
      default:
        return 'No hay citas';
    }
  }

  List<AppointmentList> _appointmentsForTab(int tabIndex) {
    return appointments
        .where((appointment) => matchesTab(appointment, tabIndex))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTabSection(
      title: 'Citas',
      tabs: const [
        'Confirmadas',
        'Pendientes',
        'No atendidas',
      ],
      contentBuilder: (context, index) {
        final filteredAppointments = _appointmentsForTab(index);

        if (filteredAppointments.isEmpty) {
          return CustomTabSection.emptyMessageBox(
            context,
            emptyMessageForTab(index),
          );
        }

        return AppointmentListWidget(
          appointments: filteredAppointments,
        );
      },
    );
  }
}
