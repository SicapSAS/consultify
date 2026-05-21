import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CustomEmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? iconColor;

  const CustomEmptyStateWidget({
    super.key,
    required this.message,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: AppDimens.bigIcon(context),
            color: iconColor ?? AppColors.textPrimary
          ),
          SizedBox(height: AppDimens.heightPercentage(0.02, context)),
          Text(
            message,
            style: TextStyle(
              fontSize: AppDimens.normalText(context),
              color: AppColors.textPrimary
            )
          )
        ]
      )
    );
  }
}
