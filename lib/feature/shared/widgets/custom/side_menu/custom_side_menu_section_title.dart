import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CustomSideMenuSectionTitle extends StatelessWidget {
  final String label;

  const CustomSideMenuSectionTitle({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.secondary.withValues(alpha: 0.6),
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5
        )
      )
    );
  }
}
