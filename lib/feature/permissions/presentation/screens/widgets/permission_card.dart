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
    final radius = AppDimens.widthPercentage(0.1, context);

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.03, context),
          vertical: AppDimens.heightPercentage(0.01, context)
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimens.widthPercentage(0.02, context)),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(radius * 0.85)
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: AppDimens.bigIcon(context) * 0.9
              )
            ),
            SizedBox(width: AppDimens.widthPercentage(0.04, context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimens.normalText(context)
                    )
                  ),
                  SizedBox(height: AppDimens.heightPercentage(0.004, context)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: value ? AppColors.successBackground
                        : AppColors.textPrimary.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimens.littleText(context)
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