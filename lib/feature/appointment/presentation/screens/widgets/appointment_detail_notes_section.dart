import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

class AppointmentDetailNotesSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final bool highlighted;

  const AppointmentDetailNotesSection({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    if (highlighted) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.tertiaryBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.secondaryButton.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    return AppointmentDetailSectionCard(
      title: title,
      icon: icon,
      children: [
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary.withValues(alpha: 0.75),
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
