import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorDetailHeader extends StatelessWidget {
  final ShowDoctor doctor;

  const DoctorDetailHeader({
    super.key,
    required this.doctor,
  });

  String _initialsFromName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.secondaryButton.withValues(alpha: 0.15),
              ),
              child: Center(
                child: Text(
                  _initialsFromName(doctor.name),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _DoctorInfoRow(
                  icon: FontAwesomeIcons.userDoctor.data,
                  text: doctor.specialty,
                ),
                const SizedBox(height: 10),
                _DoctorInfoRow(
                  icon: FontAwesomeIcons.envelope.data,
                  text: doctor.email,
                ),
                const SizedBox(height: 10),
                _DoctorInfoRow(
                  icon: FontAwesomeIcons.idCard.data,
                  text: '${doctor.documentType} · ${doctor.documentId}',
                ),
                const SizedBox(height: 10),
                _DoctorInfoRow(
                  icon: FontAwesomeIcons.addressCard.data,
                  text: 'Tarjeta profesional: ${doctor.professionalCardNumber}',
                ),
                const SizedBox(height: 10),
                _DoctorInfoRow(
                  icon: doctor.isActive
                      ? FontAwesomeIcons.userCheck.data
                      : FontAwesomeIcons.userSlash.data,
                  text: doctor.isActive ? 'Doctor habilitado' : 'Doctor inhabilitado',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DoctorInfoRow({
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
          color: AppColors.textPrimary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
