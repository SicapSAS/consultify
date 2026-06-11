import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileHeader extends ConsumerWidget {
  final String name;
  final String roleLabel;
  final bool isActive;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.roleLabel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayName = name.trim().isEmpty ? 'Usuario' : name.trim();
    final displayRole = roleLabel.trim().isEmpty ? 'Usuario' : roleLabel.trim();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary,
            AppColors.primaryButton,
            AppColors.secondaryButton,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textSecondary,
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.logout, size: 18),
                label: const Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              child: CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.textSecondary,
                child: Text(
                  _initialsFromName(displayName),
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              displayName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.idBadge.data,
                    size: 14,
                    color: AppColors.textSecondary.withValues(alpha: 0.9),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayRole,
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.95),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _StatusBadge(isActive: isActive),
          ],
        ),
      ),
    );
  }

  String _initialsFromName(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.elementAt(1)[0]}'.toUpperCase();
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;

  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.successBackground : AppColors.warningBackground;
    final label = isActive ? 'Cuenta activa' : 'Cuenta inactiva';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle_outline : Icons.info_outline,
            size: 14,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
