import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;

  const ProfileSectionTitle({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: AppColors.secondaryButton,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
