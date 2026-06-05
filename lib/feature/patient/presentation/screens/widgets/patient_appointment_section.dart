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
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.04,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700
          )
        ),
        SizedBox(height: size.height * 0.012),
      if (appointments.isEmpty)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.018
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(
              size.width * 0.02
            )
          ),
          child: Text(
            emptyMessage,
            style: TextStyle(
              fontSize: size.width * 0.03,
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
            height: size.height * 0.012,
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
