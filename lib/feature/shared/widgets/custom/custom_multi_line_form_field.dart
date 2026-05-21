import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:consultify/config/config.dart';

class CustomMultiLineFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomMultiLineFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
  });

  static const int _maxLen = 350;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.multiline,
      maxLength: _maxLen,
      maxLines: null,
      minLines: 3,
      inputFormatters: [
        LengthLimitingTextInputFormatter(_maxLen)
      ],
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppDimens.normalText(context)
        ),
        filled: true,
        fillColor: AppColors.tertiaryBackground,
        contentPadding: EdgeInsets.symmetric(
          vertical: AppDimens.heightPercentage(0.01, context),
          horizontal: AppDimens.widthPercentage(0.02, context)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.widthPercentage(0.02, context)
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary,
            width: AppDimens.widthPercentage(0.003, context)
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.widthPercentage(0.02, context)
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary,
            width: AppDimens.widthPercentage(0.003, context)
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimens.widthPercentage(0.02, context)
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary, 
            width: AppDimens.widthPercentage(0.003, context)
          )
        ),
        counter: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final remaining = _maxLen - value.text.length;
            return Text(
              '$remaining caracteres',
              style: TextStyle(
                fontSize: AppDimens.normalText(context),
                color: AppColors.textPrimary
              )
            );
          }
        )
      ),
      style:  TextStyle( 
        fontSize: AppDimens.subtitleText(context), 
        color: AppColors.textPrimary.withValues(alpha: 0.78)
      )
    );
  }
}
