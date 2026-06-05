import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeGreeting extends ConsumerWidget {
  const HomeGreeting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.06,
        size.height * 0.02,
        size.width * 0.06,
        size.height * 0.012,
      ),
      child: Text(
        'Hola, qué vas hacer hoy?',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: size.width * 0.04,
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
