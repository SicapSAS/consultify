import 'package:flutter/material.dart';

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
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(
          12
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: accentColor,
          fontSize: 18,
          fontWeight: FontWeight.w600
        )
      )
    );
  }
}
