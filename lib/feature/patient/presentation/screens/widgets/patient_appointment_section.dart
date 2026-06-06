import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class PatientAppointmentSection extends StatelessWidget {
  final String title;
  final List<AppointmentDetail> appointments;
  final String emptyMessage;

  const PatientAppointmentSection({
    super.key,
    required this.title,
    required this.appointments,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700
          )
        ),
        SizedBox(height: 12),
      if (appointments.isEmpty)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(
              12
            )
          ),
          child: Text(
            emptyMessage,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary.withValues(alpha: 0.55),
              fontWeight: FontWeight.w500
            )
          )
        )
      else
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: appointments.length,
          separatorBuilder: (context, _) => SizedBox(
            height: 12,
          ),
          itemBuilder: (context, index) {
            return PatientAppointmentTile(
              appointment: appointments[index]
            );
          }
        )
      ]
    );
  }
}
