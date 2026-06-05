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
          fontSize: 20
        ),
        filled: true,
        fillColor: AppColors.primaryBackground,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20
          ),
          borderSide: BorderSide(
            color: AppColors.infoBackground,
            width: 3
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20
          ),
          borderSide: BorderSide(
            color: AppColors.disabledBackground.withValues(alpha: 0.5),
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20
          ),
          borderSide: BorderSide(
            color: AppColors.infoBackground, 
            width: 3
          )
        ),
        counter: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final remaining = _maxLen - value.text.length;
            return Text(
              '$remaining caracteres',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textPrimary
              )
            );
          }
        )
      ),
      style:  TextStyle( 
        fontSize: 20, 
        color: AppColors.textPrimary.withValues(alpha: 0.78)
      )
    );
  }
}
