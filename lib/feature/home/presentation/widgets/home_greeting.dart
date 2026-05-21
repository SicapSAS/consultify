import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeGreeting extends ConsumerWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.02, context),
        AppDimens.widthPercentage(0.06, context),
        AppDimens.heightPercentage(0.012, context),
      ),
      child: Text(
        'Hola, qué vas hacer hoy?',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: AppDimens.normalText(context),
        ),
      ),
    );
  }
}

/* String _firstNameFromFullName(String? fullName) {
  final trimmed = fullName?.trim() ?? '';
  if (trimmed.isEmpty) return '';
  return trimmed.split(RegExp(r'\s+')).first;
} */
