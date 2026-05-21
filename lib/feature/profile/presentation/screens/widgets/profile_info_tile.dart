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
    final radius = AppDimens.widthPercentage(0.04, context);

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.05, context),
          vertical: AppDimens.heightPercentage(0.018, context)
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimens.widthPercentage(0.025, context)),
              decoration: BoxDecoration(
                color: AppColors.secondaryButton.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(radius * 0.85),
              ),
              child: Icon(
                icon,
                color: AppColors.secondary,
                size: AppDimens.normalIcon(context)
              )
            ),
            SizedBox(width: AppDimens.widthPercentage(0.04, context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.textPrimary.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w500,
                      fontSize: AppDimens.littleText(context)
                    )
                  ),
                  SizedBox(height: AppDimens.heightPercentage(0.004, context)),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimens.normalText(context)
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
