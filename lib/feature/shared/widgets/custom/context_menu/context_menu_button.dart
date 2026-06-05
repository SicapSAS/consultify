import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Botón de menú contextual reutilizable (tres puntos u otro ícono).
///
/// Muestra un [PopupMenuButton] con las opciones definidas en [items].
/// La acción se delega a [onSelected] cuando el usuario elige una opción.
class ContextMenuButton<T> extends StatelessWidget {
  final List<ContextMenuItem<T>> items;
  final ValueChanged<T>? onSelected;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor;
  final double? iconSize;
  final double? menuElevation;
  final Color? menuColor;

  const ContextMenuButton({
    super.key,
    required this.items,
    this.onSelected,
    this.child,
    this.padding,
    this.iconColor,
    this.iconSize,
    this.menuElevation,
    this.menuColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = 10.0;

    return PopupMenuButton<T>(
      padding: EdgeInsets.zero,
      elevation: menuElevation ?? 4,
      color: menuColor ?? AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      offset: Offset(0, 10),
      onSelected: onSelected,
      itemBuilder: (context) => items.map(
        (item) => PopupMenuItem<T>(
          value: item.value,
          child: _ContextMenuItemTile(item: item)
        )
      ).toList(),
      child: child ?? Padding(
        padding: padding ?? EdgeInsets.all(5),
        child: Icon(
          FontAwesomeIcons.ellipsisVertical.data,
          color: iconColor ?? AppColors.iconDark,
          size: iconSize ?? 20
        )
      )
    );
  }
}

class _ContextMenuItemTile extends StatelessWidget {
  final ContextMenuItem<dynamic> item;

  const _ContextMenuItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final textColor = item.isDestructive
        ? AppColors.errorBackground
        : AppColors.textPrimary;

    return Row(
      children: [
        if (item.icon != null) ...[
          Icon(
            item.icon,
            size: 20,
            color: textColor.withValues(alpha: item.isDestructive ? 1 : 0.7)
          ),
          SizedBox(width: 10)
        ],
        Expanded(
          child: Text(
            item.label,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w500
            )
          )
        )
      ]
    );
  }
}
