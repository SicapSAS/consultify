import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';

class CustomSideMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final String? route;
  final VoidCallback? onTap;

  const CustomSideMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected 
        ? AppColors.secondaryButton.withValues(alpha: 0.15) 
        : Colors.transparent;
    
    final iconColor = isSelected 
        ? AppColors.secondaryButton 
        : AppColors.secondary;
    
    final textColor = isSelected 
        ? AppColors.secondaryButton 
        : AppColors.secondary;

    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else if (route != null && route!.isNotEmpty) {
          context.go(route!);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.02, context),
          vertical: AppDimens.heightPercentage(0.005, context),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.03, context),
          vertical: AppDimens.heightPercentage(0.015, context),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            AppDimens.smallBorderRadius(0.05, context),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: AppDimens.normalIcon(context),
            ),
            SizedBox(width: AppDimens.widthPercentage(0.03, context)),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: AppDimens.titleText(context) * 0.8,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
