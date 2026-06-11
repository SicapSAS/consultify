import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class LabeledFloatingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  final String? heroTag;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? labelColor;
  final Color? labelBackgroundColor;
  final double? iconSize;
  final double? labelFontSize;
  final EdgeInsetsGeometry? labelPadding;
  final double? borderRadius;
  final List<BoxShadow>? labelBoxShadow;
  final List<BoxShadow>? buttonBoxShadow;

  static const double reservedHeight = 96;

  const LabeledFloatingActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.add,
    this.heroTag,
    this.backgroundColor,
    this.iconColor,
    this.labelColor,
    this.labelBackgroundColor,
    this.iconSize,
    this.labelFontSize,
    this.labelPadding,
    this.borderRadius,
    this.labelBoxShadow,
    this.buttonBoxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Etiqueta
        Container(
          padding: labelPadding ?? EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12
          ),
          decoration: BoxDecoration(
            color: labelBackgroundColor ?? AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(
              borderRadius ?? 12
            ),
            boxShadow: labelBoxShadow ?? [
              BoxShadow(
                color: AppColors.textPrimary,
                blurRadius: 12,
                offset: Offset(0, 12)
              )
            ]
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: labelFontSize ?? 12,
              color: labelColor ?? AppColors.textInfoDark
            )
          )
        ),
        SizedBox( height: 2 ),
        // Botón flotante
        Container(
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: buttonBoxShadow ?? [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.4),
                blurRadius: 3,
                offset: Offset(0, 5)
              )
            ]
          ),
          child: FloatingActionButton(
            heroTag: heroTag,
            backgroundColor: backgroundColor ?? AppColors.infoBackground,
            shape: CircleBorder(),
            onPressed: onPressed,
            child: Icon(
              icon,
              color: iconColor ?? AppColors.primaryBackground,
              size: iconSize ?? 30,
            )
          )
        )
      ]
    );
  }
}
