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

  List<ContextMenuItem<PatientMenuAction>> _buildMenuItems() {
    return [
      const ContextMenuItem<PatientMenuAction>(
        value: PatientMenuAction.update,
        label: 'Actualizar paciente',
        icon: Icons.edit_outlined,
      ),
      if (patient.isActive)
        const ContextMenuItem<PatientMenuAction>(
          value: PatientMenuAction.disable,
          label: 'Inhabilitar paciente',
          icon: Icons.block_outlined,
          isDestructive: true,
        )
      else
        const ContextMenuItem<PatientMenuAction>(
          value: PatientMenuAction.enable,
          label: 'Habilitar paciente',
          icon: Icons.check_circle_outline,
        ),
    ];
  }

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
    final radius = 10.0;
    final rowGap = 8.0;
    final cardPadding = 15.0;
    final menuIconSize = 20.0;

    final isInactive = !patient.isActive;

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
                      ClipOval(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryButton.withValues(alpha: 0.15),
                          ),
                          child: Center(
                            child: Text(
                              _initialsFromName(patient.name),
                              style: TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              )
                            )
                          )
                        )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              patient.name,
                              style: TextStyle(
                                fontSize: 19,
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
                                text: patient.email.trim()
                              )
                            ]
                          ]
                        )
                      )
                    ]
                  )
                )
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 6,
                child: Center(
                  child: ContextMenuButton<PatientMenuAction>(
                    items: _buildMenuItems(),
                    onSelected: onMenuAction,
                    iconColor: AppColors.iconDark,
                    iconSize: menuIconSize,
                    padding: EdgeInsets.all(5),
                  ),
                ),
              ),
            ],
          ),
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
          size: 20,
          color: AppColors.textPrimary.withValues(alpha: 0.45),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17,
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
