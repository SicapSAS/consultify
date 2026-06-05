import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CustomLabeledMultilineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLength;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const CustomLabeledMultilineTextField({
    super.key,
    required this.controller,
    required this.maxLength,
    this.label = 'Descripción (Opcional)',
    this.hintText = 'Ingrese observaciones (opcional)',
    this.minLines = 2,
    this.maxLines = 3,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.55),
            fontSize: size.width * 0.03
          )
        ),
        SizedBox(height: size.height * 0.008),
        TextField(
          controller: controller,
          enabled: enabled,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            maxLength,
          }) {
            final cap = maxLength ?? this.maxLength;
            return Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.004
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$currentLength/$cap',
                  style: TextStyle(
                    color: AppColors.textPrimary.withValues(alpha: 0.45),
                    fontSize: size.width * 0.03
                  )
                )
              )
            );
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.35),
              fontSize: size.width * 0.03
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.014
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                size.width * 0.02
              ),
              borderSide: BorderSide(
                color: AppColors.textPrimary.withValues(alpha: 0.2)
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                size.width * 0.02
              ),
              borderSide: BorderSide(
                color: AppColors.textPrimary.withValues(alpha: 0.2)
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                size.width * 0.02
              ),
              borderSide: BorderSide(color: AppColors.secondaryButton)
            )
          ),
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: size.width * 0.03
          ),
          onChanged: onChanged
        )
      ]
    );
  }
}
