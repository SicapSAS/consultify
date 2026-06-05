import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';


class PermissionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const PermissionCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.1;

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(size.width * 0.02),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(radius * 0.85)
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: size.width * 0.08 * 0.9
              )
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.04
                    )
                  ),
                  SizedBox(height: size.height * 0.004),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: value ? AppColors.successBackground
                        : AppColors.textPrimary.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.03
                    )
                  )
                ]
              )
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.secondaryBackground;
                }
                return AppColors.tertiaryBackground;
              }),
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.secondaryButtonDark;
                }
                return AppColors.textPrimary.withValues(alpha: 0.22);
              })
            )
          ]
        )
      )
    );
  }
}