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
            size: 10,
            color: iconColor ?? AppColors.textPrimary
          ),
          SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary
            )
          )
        ]
      )
    );
  }
}
