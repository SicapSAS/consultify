import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

/// Chip de estado reutilizable (texto + color de acento).
class StatusBadge extends StatelessWidget {
  final String label;
  final Color accentColor;

  const StatusBadge({
    super.key,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final text = label.trim().isEmpty ? '—' : label.trim();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.widthPercentage(0.025, context),
        vertical: AppDimens.heightPercentage(0.004, context),
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(
          AppDimens.smallBorderRadius(0.01, context)
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: accentColor,
          fontSize: AppDimens.tinyText(context),
          fontWeight: FontWeight.w600
        )
      )
    );
  }
}
