import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

/// Utilidad para filtrar listas por texto de búsqueda (coincidencia parcial, sin distinguir mayúsculas).
class ListSearchFilter {
  const ListSearchFilter._();

  static bool matches(String query, String searchableText) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return true;
    return searchableText.toLowerCase().contains(normalizedQuery);
  }

  static List<T> filter<T>(
    List<T> items,
    String query,
    String Function(T item) searchableText,
  ) {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return items;

    return items
        .where((item) => matches(query, searchableText(item)))
        .toList();
  }
}

/// Campo de búsqueda con borde redondeado e ícono a la izquierda, pensado para reutilizar en varias pantallas.
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.leading,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction = TextInputAction.search,
    this.borderColor,
    this.backgroundColor,
    this.contentPadding,
  });

  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? leading;
  final FocusNode? focusNode;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction textInputAction;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  static const double _radius = 15;

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(
      color: borderColor ?? AppColors.infoBackground,
      width: 1,
    );

    final decoration = BoxDecoration(
      color: backgroundColor ?? AppColors.primaryBackground,
      borderRadius: BorderRadius.circular(_radius),
      border: Border.fromBorderSide(borderSide),
    );

    final icon = leading ??
        Icon(
          Icons.search,
          size: 18,
          color: borderColor ?? AppColors.secondaryButtonDark,
        );

    return Container(
      decoration: decoration,
      child: Row(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 14, right: 8),
            child: icon,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              readOnly: readOnly,
              autofocus: autofocus,
              textInputAction: textInputAction,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
              cursorColor: AppColors.secondaryButtonDark,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: AppColors.textPrimary.withValues(alpha: 0.45),
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
