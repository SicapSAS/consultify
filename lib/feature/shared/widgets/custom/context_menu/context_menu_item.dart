import 'package:flutter/material.dart';

/// Opción individual para [ContextMenuButton].
class ContextMenuItem<T> {
  final T value;
  final String label;
  final IconData? icon;
  final bool isDestructive;

  const ContextMenuItem({
    required this.value,
    required this.label,
    this.icon,
    this.isDestructive = false,
  });
}
