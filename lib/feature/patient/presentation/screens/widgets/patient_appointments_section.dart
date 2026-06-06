import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientAppointmentsSection extends StatelessWidget {
  final PatientShow history;

  const PatientAppointmentsSection({
    super.key,
    required this.history,
  });

  List<AppointmentDetail> _allAppointments() {
    if (history.appointments.isNotEmpty) {
      return history.appointments;
    }

    final seen = <String>{};
    final result = <AppointmentDetail>[];

    for (final appointment in [
      ...history.upcoming,
      ...history.past,
    ]) {
      if (seen.add(appointment.id)) {
        result.add(appointment);
      }
    }

    return result;
  }

  bool _isAttended(String status) {
    final normalizedStatus = status.toUpperCase();
    return normalizedStatus == 'ATTENDED' || normalizedStatus == 'COMPLETED';
  }

  bool _isCancelled(String status) {
    final normalizedStatus = status.toUpperCase();
    return normalizedStatus == 'CANCELLED' ||
        normalizedStatus == 'NOT_ATTENDED';
  }

  List<AppointmentDetail> _appointmentsForTab(int index) {
    switch (index) {
      case 0:
        return List<AppointmentDetail>.from(history.upcoming)
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
      case 1:
        return _allAppointments()
            .where((appointment) => _isAttended(appointment.status))
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      case 2:
        return _allAppointments()
            .where((appointment) => _isCancelled(appointment.status))
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      default:
        return [];
    }
  }

  String _emptyMessageForTab(int index) {
    switch (index) {
      case 0:
        return 'No hay citas próximas';
      case 1:
        return 'No hay citas atendidas';
      case 2:
        return 'No hay citas canceladas';
      default:
        return 'No hay citas';
    }
  }

  @override
  Widget build(BuildContext context) {

    return CustomTabSection(
      title: 'Citas',
      tabs: const [
        'Próximas',
        'Atendidas',
        'Canceladas',
      ],
      contentBuilder: (context, index) {
        final appointments = _appointmentsForTab(index);

        if (appointments.isEmpty) {
          return CustomTabSection.emptyMessageBox(
            context,
            _emptyMessageForTab(index),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appointments.length,
          separatorBuilder: (context, _) => SizedBox(
            height: 12,
          ),
          itemBuilder: (context, itemIndex) {
            return PatientAppointmentTile(
              appointment: appointments[itemIndex],
            );
          },
        );
      },
    );
  }
}
