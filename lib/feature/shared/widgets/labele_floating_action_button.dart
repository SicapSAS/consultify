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
            vertical: AppDimens.heightPercentage(0.007, context),
            horizontal: AppDimens.widthPercentage(0.017, context)
          ),
          decoration: BoxDecoration(
            color: labelBackgroundColor ?? AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimens.widthPercentage(0.05, context)
            ),
            boxShadow: labelBoxShadow ?? [
              BoxShadow(
                color: AppColors.textPrimary,
                blurRadius: AppDimens.widthPercentage(0.02, context),
                offset: Offset(0, AppDimens.widthPercentage(0.015, context))
              )
            ]
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: labelFontSize ?? AppDimens.widthPercentage(0.025, context),
              color: labelColor ?? AppColors.textInfo
            )
          )
        ),
        SizedBox(
          height: AppDimens.heightPercentage(0.005, context)
        ),
        // Botón flotante
        Container(
          width: AppDimens.widthPercentage(0.13, context),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: buttonBoxShadow ?? [
              BoxShadow(
                color: AppColors.textPrimary.withOpacity(0.4),
                blurRadius: AppDimens.widthPercentage(0.02, context),
                offset: Offset(0, AppDimens.widthPercentage(0.015, context))
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
              size: iconSize ?? AppDimens.bigIcon(context),
            )
          )
        )
      ]
    );
  }
}
