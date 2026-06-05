import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientDetailHeader extends StatelessWidget {
  final PatientDetail patient;
  final int totalAppointments;

  const PatientDetailHeader({
    super.key,
    required this.patient,
    required this.totalAppointments,
  });


  @override
  Widget build(BuildContext context) {
    final cardPadding = 15.0;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4)
          )
        ]
      ),
      padding: EdgeInsets.all(cardPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700
                  )
                ),
                SizedBox(height: 10),
                _PatientInfoRow(
                  icon: FontAwesomeIcons.idCard.data,
                  text: '${patient.documentType} · ${patient.documentId}'
                ),
                SizedBox(height: 10),
                _PatientInfoRow(
                  icon: FontAwesomeIcons.calendarCheck.data,
                  text: '$totalAppointments cita${totalAppointments == 1 ? '' : 's'} registrada${totalAppointments == 1 ? '' : 's'}'
                ),
                SizedBox(height: 10),
                _PatientInfoRow(
                  icon: patient.isActive
                      ? FontAwesomeIcons.userCheck.data
                      : FontAwesomeIcons.userSlash.data,
                  text: patient.isActive
                      ? 'Paciente activo'
                      : 'Paciente inactivo',
                ),
              ]
            )
          )
        ]
      )
    );
  }
}

class _PatientInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PatientInfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500
            )
          )
        )
      ]
    );
  }
}
