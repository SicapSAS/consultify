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
    final size = MediaQuery.of(context).size;
    final text = label.trim().isEmpty ? '—' : label.trim();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.025,
        vertical: size.height * 0.004,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(
          size.width * 0.01
        )
      ),
      child: Text(
        text,
        style: TextStyle(
          color: accentColor,
          fontSize: size.width * 0.03,
          fontWeight: FontWeight.w600
        )
      )
    );
  }
}
