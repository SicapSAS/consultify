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
            fontSize: AppDimens.subtitleText(context),
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700
          )
        ),
        SizedBox(height: AppDimens.heightPercentage(0.012, context)),
      if (appointments.isEmpty)
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.widthPercentage(0.04, context),
            vertical: AppDimens.heightPercentage(0.018, context)
          ),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(
              AppDimens.smallBorderRadius(0.02, context)
            )
          ),
          child: Text(
            emptyMessage,
            style: TextStyle(
              fontSize: AppDimens.littleText(context),
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
            height: AppDimens.heightPercentage(0.012, context),
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
