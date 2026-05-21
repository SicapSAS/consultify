import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';


class CustomTextFormField extends StatelessWidget {

  final String? label;
  final bool showLabel;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final Color? borderColor;

  const CustomTextFormField({
    super.key, 
    this.label,
    this.showLabel = true,
    this.hint,
    this.controller,
    this.errorMessage, 
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.backgroundColor,
    this.onChanged, 
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(
        AppDimens.smallBorderRadius(0.04, context)
      )
    );

    final borderRadius = Radius.circular(AppDimens.smallBorderRadius(0.04, context));

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: borderRadius, 
          bottomLeft: borderRadius, 
          bottomRight: borderRadius,
          topRight: borderRadius,
        ),
        border: Border.all(color: borderColor ?? Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: Offset(0,5)
          )
        ]
      ),
        child: TextFormField(
        controller: controller,
        enabled: enabled,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style:  TextStyle( 
          fontSize: AppDimens.subtitleText(context), 
          color: AppColors.textPrimary.withValues(alpha: 0.78)
        ),
        decoration: InputDecoration(
          floatingLabelStyle:  TextStyle(
            color: AppColors.textPrimary, 
            fontWeight: FontWeight.bold, 
            fontSize: AppDimens.subtitleText(context)
          ),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith( borderSide: BorderSide( color: Colors.transparent )),
          focusedErrorBorder: border.copyWith( borderSide: BorderSide( color: Colors.transparent )),
          isDense: true,
          // true: etiqueta flotante; false: [label] va como hint dentro (como Descripción).
          label: (label != null && showLabel) ? Text(label!) : null,
          hintText: hint ?? (label != null && !showLabel ? label : null),
          hintStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimens.normalText(context)
          ),
          errorText: errorMessage,
          focusColor: colors.primary,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        )
      )
    );
  }
}