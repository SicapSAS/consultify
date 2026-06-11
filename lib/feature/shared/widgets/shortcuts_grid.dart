import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';

class ShortcutItem {
  final IconData icon;
  final double? iconSize;
  final String label;
  final String? route;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;

  const ShortcutItem({
    required this.icon,
    this.iconSize,
    required this.label,
    this.route,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
  });
}

class ShortcutsGrid extends StatelessWidget {
  final List<ShortcutItem> shortcuts;
  final int crossAxisCount;
  final double childAspectRatio;
  final double spacing;
  final double runSpacing;

  /// [WrapAlignment.start] mantiene columnas alineadas a la izquierda cuando la última fila está incompleta.
  final WrapAlignment wrapAlignment;

  const ShortcutsGrid({
    super.key,
    required this.shortcuts,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.0,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.wrapAlignment = WrapAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final outerPadding = 12.0;
    return Padding(
      padding: EdgeInsets.all(outerPadding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          final tileW =
              (maxW - spacing * (crossAxisCount - 1)) / crossAxisCount;
          final tileH = tileW / childAspectRatio;

          return Wrap(
            alignment: wrapAlignment,
            spacing: spacing,
            runSpacing: runSpacing,
            children: [
            for (final item in shortcuts)
              SizedBox(
                width: tileW,
                height: tileH,
                child: _ShortcutCard(shortcut: item)
              )
            ]
          );
        }
      )
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final ShortcutItem shortcut;

  const _ShortcutCard({
    required this.shortcut,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = shortcut.iconColor ?? AppColors.secondaryButton;
    final backgroundColor =
        shortcut.backgroundColor ?? AppColors.secondaryBackground;
    final iconPixelSize = shortcut.iconSize ?? 14.4;

    return InkWell(
      onTap: () {
        if (shortcut.onTap != null) {
          shortcut.onTap!();
        } else if (shortcut.route != null && shortcut.route!.isNotEmpty) {
          context.go(shortcut.route!);
        }
      },
      borderRadius: BorderRadius.circular(
        12,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            12,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, 2)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              shortcut.icon,
              color: iconColor,
              size: iconPixelSize,
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8
              ),
              child: Text(
                shortcut.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 18,
                )
              )
            )
          ]
        )
      )
    );
  }
}
