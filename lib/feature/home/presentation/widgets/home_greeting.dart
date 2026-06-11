import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeGreeting extends ConsumerWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        12,
      ),
      child: Text(
        'Hola, qué vas hacer hoy?',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 18,
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
