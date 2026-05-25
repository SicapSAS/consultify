import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PatientListTile extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;
  final ValueChanged<PatientMenuAction>? onMenuAction;

  const PatientListTile({
    super.key,
    required this.patient,
    this.onTap,
    this.onMenuAction,
  });

  static const _menuItems = [
    ContextMenuItem<PatientMenuAction>(
      value: PatientMenuAction.update,
      label: 'Actualizar paciente',
      icon: Icons.edit_outlined,
    ),
    ContextMenuItem<PatientMenuAction>(
      value: PatientMenuAction.disable,
      label: 'Inhabilitar paciente',
      icon: Icons.block_outlined,
      isDestructive: true,
    ),
  ];

  bool _hasText(String? value) {
    if (value == null) return false;
    return value.trim().isNotEmpty;
  }

  String _initialsFromName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }
    final surnameIndex = parts.length >= 3 ? 2 : 1;
    return '${parts[0][0]}${parts[surnameIndex][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final radius = AppDimens.smallBorderRadius(0.02, context);
    final rowGap = AppDimens.heightPercentage(0.006, context);
    final cardPadding = AppDimens.widthPercentage(0.04, context);
    final menuIconSize = AppDimens.normalIcon(context) * 0.85;

    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                cardPadding,
                cardPadding,
                cardPadding + menuIconSize + 4,
                cardPadding,
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(radius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppDimens.widthPercentage(0.12, context),
                      height: AppDimens.widthPercentage(0.12, context),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryButton.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          AppDimens.smallBorderRadius(0.07, context),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _initialsFromName(patient.name),
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimens.subtitleText(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimens.widthPercentage(0.03, context)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            patient.name,
                            style: TextStyle(
                              fontSize: AppDimens.subtitleText(context),
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (_hasText(patient.email)) ...[
                            SizedBox(height: rowGap),
                            _PatientDetailRow(
                              icon: FontAwesomeIcons.envelope.data,
                              text: patient.email.trim(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 6,
              child: Center(
                child: ContextMenuButton<PatientMenuAction>(
                  items: _menuItems,
                  onSelected: onMenuAction,
                  iconColor: AppColors.iconDark,
                  iconSize: menuIconSize,
                  padding: EdgeInsets.all(AppDimens.widthPercentage(0.01, context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatientDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PatientDetailRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: AppDimens.tinyIcon(context),
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
        SizedBox(width: AppDimens.widthPercentage(0.02, context)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppDimens.littleText(context),
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
