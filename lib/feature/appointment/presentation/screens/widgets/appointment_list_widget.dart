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
    final size = MediaQuery.of(context).size;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: size.height * 0.02),
      itemCount: appointments.length,
      separatorBuilder: (context, _) => SizedBox(height: size.height * 0.015),
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
