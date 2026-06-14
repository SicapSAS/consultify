import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpecialityCard extends StatelessWidget {
  final Specialty specialty;
  final ValueChanged<SpecialityMenuAction>? onMenuAction;

  const SpecialityCard({
    super.key,
    required this.specialty,
    this.onMenuAction,
  });

  List<ContextMenuItem<SpecialityMenuAction>> _buildMenuItems() {
    return [
      const ContextMenuItem<SpecialityMenuAction>(
        value: SpecialityMenuAction.update,
        label: 'Editar especialidad',
        icon: Icons.edit_outlined,
      ),
      const ContextMenuItem<SpecialityMenuAction>(
        value: SpecialityMenuAction.delete,
        label: 'Eliminar especialidad',
        icon: Icons.delete_outline,
        isDestructive: true,
      ),
      if (specialty.isActive)
        const ContextMenuItem<SpecialityMenuAction>(
          value: SpecialityMenuAction.disable,
          label: 'Inhabilitar especialidad',
          icon: Icons.block_outlined,
          isDestructive: true,
        )
      else
        const ContextMenuItem<SpecialityMenuAction>(
          value: SpecialityMenuAction.enable,
          label: 'Habilitar especialidad',
          icon: Icons.check_circle_outline,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const radius = 10.0;
    const cardPadding = 15.0;
    const menuIconSize = 20.0;

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
              Positioned(
                top: 0,
                bottom: 0,
                right: 6,
                child: Center(
                  child: ContextMenuButton<SpecialityMenuAction>(
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
