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
            size: 10,
            color: iconColor ?? AppColors.errorBackground
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary
              ),
              textAlign: TextAlign.center
            )
          ),
          if (onRetry != null) ...[
            SizedBox(height:  10),
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
