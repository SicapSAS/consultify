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
    final size = MediaQuery.of(context).size;
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
          fontSize: size.width * 0.03
        ),
        filled: true,
        fillColor: AppColors.tertiaryBackground,
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
          horizontal: size.width * 0.02
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            size.width * 0.02
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary,
            width: size.width * 0.003
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            size.width * 0.02
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary,
            width: size.width * 0.003
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            size.width * 0.02
          ),
          borderSide: BorderSide(
            color: AppColors.textSecondary, 
            width: size.width * 0.003
          )
        ),
        counter: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) {
            final remaining = _maxLen - value.text.length;
            return Text(
              '$remaining caracteres',
              style: TextStyle(
                fontSize: size.width * 0.03,
                color: AppColors.textPrimary
              )
            );
          }
        )
      ),
      style:  TextStyle( 
        fontSize: size.width * 0.03, 
        color: AppColors.textPrimary.withValues(alpha: 0.78)
      )
    );
  }
}
