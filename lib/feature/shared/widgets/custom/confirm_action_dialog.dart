import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// Diálogo de confirmación reutilizable con acciones cancelar / confirmar.
class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirmar',
    this.cancelLabel = 'Cancelar',
    this.isDestructive = false,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmActionDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: AppColors.secondaryBackground,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: size.width * 0.04,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: size.width * 0.03,
          fontWeight: FontWeight.normal,
        )
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFilledButton(
              text: cancelLabel,
              onPressed: () => Navigator.of(context).pop(false),
              buttonColor: AppColors.disabledButton,
              textColor: AppColors.textSecondary
            ),
            SizedBox(width: size.width * 0.02),
            CustomFilledButton(
              text: confirmLabel,
              onPressed: () => Navigator.of(context).pop(true),
              buttonColor: isDestructive ? AppColors.errorBackground : AppColors.secondaryButton,
              textColor: isDestructive ? AppColors.primary : AppColors.secondaryBackground
            )
          ]
        )
      ]
    );
  }
}
