import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpecialityCard extends StatelessWidget {
  final Specialty specialty;

  const SpecialityCard({
    super.key,
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 10.0;
    const cardPadding = 15.0;

    final isInactive = !specialty.isActive;

    return Opacity(
      opacity: isInactive ? 0.72 : 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(cardPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.secondaryButton.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  FontAwesomeIcons.stethoscope.data,
                  color: AppColors.secondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  specialty.name,
                  style: const TextStyle(
                    fontSize: 19,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
