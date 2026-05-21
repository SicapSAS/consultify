import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/shared/shared.dart';

class CustomErrorStateWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final String? buttonText;
  final VoidCallback? onRetry;

  const CustomErrorStateWidget({
    super.key,
    required this.message,
    this.icon,
    this.iconColor,
    this.buttonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.error_outline,
            size: AppDimens.bigIcon(context),
            color: iconColor ?? AppColors.errorBackground
          ),
          SizedBox(height: AppDimens.heightPercentage(0.02, context)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.widthPercentage(0.08, context)
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: AppDimens.normalText(context),
                color: AppColors.textPrimary
              ),
              textAlign: TextAlign.center
            )
          ),
          if (onRetry != null) ...[
            SizedBox(height: AppDimens.heightPercentage(0.03, context)),
            CustomFilledButton(
              text: buttonText ?? 'Reintentar',
              onPressed: onRetry
            )
          ]
        ]
      )
    );
  }
}
