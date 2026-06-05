import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.04;

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.018
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.025),
              decoration: BoxDecoration(
                color: AppColors.secondaryButton.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(radius * 0.85),
              ),
              child: Icon(
                icon,
                color: AppColors.secondary,
                size: size.width * 0.08
              )
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textPrimary.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.03
                    )
                  ),
                  SizedBox(height: size.height * 0.004),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}
