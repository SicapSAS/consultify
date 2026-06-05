import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';

enum AppSnackBarType {
  success,
  error,
  info,
  warning,
}

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: _backgroundColor(type),
          duration: duration,
        ),
      );
  }

  static void success(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.error);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.info);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, type: AppSnackBarType.warning);
  }

  static Color _backgroundColor(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return AppColors.successBackground;
      case AppSnackBarType.error:
        return AppColors.errorBackground;
      case AppSnackBarType.warning:
        return AppColors.warningBackground;
      case AppSnackBarType.info:
        return AppColors.secondary;
    }
  }
}
