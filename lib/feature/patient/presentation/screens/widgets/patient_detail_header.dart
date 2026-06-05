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

  String _initialsFromName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    final surnameIndex = parts.length >= 3 ? 2 : 1;
    return '${parts[0][0]}${parts[surnameIndex][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.02;
    final cardPadding = size.width * 0.04;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(radius),
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
          CircleAvatar(
            radius: size.width * 0.09,
            backgroundColor: AppColors.secondaryButton.withValues(alpha: 0.15),
            child: Text(
              _initialsFromName(patient.name),
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                fontSize: size.width * 0.04
              )
            )
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700
                  )
                ),
                SizedBox(height: size.height * 0.008),
                _PatientInfoRow(
                  icon: FontAwesomeIcons.idCard.data,
                  text: '${patient.documentType} · ${patient.documentId}'
                ),
                SizedBox(height: size.height * 0.008),
                _PatientInfoRow(
                  icon: FontAwesomeIcons.calendarCheck.data,
                  text: '$totalAppointments cita${totalAppointments == 1 ? '' : 's'} registrada${totalAppointments == 1 ? '' : 's'}'
                ),
                SizedBox(height: size.height * 0.008),
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
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: size.width * 0.08,
          color: AppColors.textPrimary.withValues(alpha: 0.45)
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: size.width * 0.03,
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500
            )
          )
        )
      ]
    );
  }
}
