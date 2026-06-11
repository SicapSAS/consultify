import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final ValueChanged<DoctorMenuAction>? onMenuAction;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onMenuAction,
  });

  List<ContextMenuItem<DoctorMenuAction>> _buildMenuItems() {
    return [
      const ContextMenuItem<DoctorMenuAction>(
        value: DoctorMenuAction.update,
        label: 'Actualizar',
        icon: Icons.edit_outlined,
      ),
      const ContextMenuItem<DoctorMenuAction>(
        value: DoctorMenuAction.delete,
        label: 'Eliminar',
        icon: Icons.delete_outline,
        isDestructive: true,
      ),
      if (doctor.isActive)
        const ContextMenuItem<DoctorMenuAction>(
          value: DoctorMenuAction.disable,
          label: 'Inhabilitar',
          icon: Icons.block_outlined,
          isDestructive: true,
        )
      else
        const ContextMenuItem<DoctorMenuAction>(
          value: DoctorMenuAction.enable,
          label: 'Habilitar',
          icon: Icons.check_circle_outline,
        ),
    ];
  }

  String _initialsFromName(String fullName) {
    final parts = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
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
    const radius = 10.0;
    const rowGap = 8.0;
    const cardPadding = 15.0;
    const menuIconSize = 20.0;

    final isInactive = !doctor.isActive;

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
                            _initialsFromName(doctor.name),
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 19,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: rowGap),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                FontAwesomeIcons.userDoctor.data,
                                size: 20,
                                color: AppColors.textPrimary.withValues(alpha: 0.45),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  doctor.specialty,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.textPrimary.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 6,
                child: Center(
                  child: ContextMenuButton<DoctorMenuAction>(
                    items: _buildMenuItems(),
                    onSelected: onMenuAction,
                    iconColor: AppColors.iconDark,
                    iconSize: menuIconSize,
                    padding: const EdgeInsets.all(5),
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
