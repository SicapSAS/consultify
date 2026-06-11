import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';

class AppointmentPickerField extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const AppointmentPickerField({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondaryBackground,
          border: Border.all(
            color: AppColors.textPrimary,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isEnabled
                  ? AppColors.secondary
                  : AppColors.textPrimary.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: isEnabled
                  ? AppColors.textPrimary
                  : AppColors.textPrimary.withValues(alpha: 0.5),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
