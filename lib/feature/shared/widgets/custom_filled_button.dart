import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final double? textSize;
  final Color? buttonColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.textSize,
    this.buttonColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(15);

    final button = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        disabledBackgroundColor: AppColors.disabledBackground,
        disabledForegroundColor: AppColors.textPrimary.withValues(alpha: 0.45),
        minimumSize: Size(
          width ?? 0,
          height ?? 50,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: radius,
            bottomRight: radius,
            topLeft: radius,
            topRight: radius,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.textSecondary,
          fontSize: textSize ?? 18,
        ),
      ),
    );

    if (width == null) return button;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(width: width, child: button),
    );
  }
}