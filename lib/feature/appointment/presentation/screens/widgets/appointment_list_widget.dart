import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentListWidget extends StatelessWidget {
  final List<AppointmentList> appointments;
  final void Function(AppointmentList appointment)? onAppointmentTap;

  const AppointmentListWidget({
    super.key,
    required this.appointments,
    this.onAppointmentTap,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 12),
      itemCount: appointments.length,
      separatorBuilder: (context, _) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return AppointmentListTile(
          appointment: appointment,
          onTap: onAppointmentTap != null
              ? () => onAppointmentTap!(appointment)
              : null,
        );
      },
    );
  }
}
