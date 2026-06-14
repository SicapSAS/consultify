import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeGreeting extends ConsumerWidget {
  const HomeGreeting({super.key});

  String _firstName(String? fullName) {
    final trimmed = fullName?.trim() ?? '';
    if (trimmed.isEmpty) return '';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final firstName = _firstName(user?.name);
    final roleLabel = Roles.toDisplayString(user?.role ?? '');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstName.isEmpty ? 'Hola, bienvenido' : 'Hola, $firstName',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _subtitleForRole(user?.role ?? ''),
              style: TextStyle(
                color: AppColors.textSecondary.withValues(alpha: 0.85),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            if (roleLabel.isNotEmpty) ...[
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
                      roleLabel,
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.95),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _subtitleForRole(String role) {
    switch (role) {
      case Roles.superAdmin:
        return 'Panel general de clínicas y operación del sistema.';
      case Roles.adminClinic:
        return 'Gestiona citas, pacientes y doctores de tu clínica.';
      case Roles.professional:
        return 'Consulta tu agenda y el estado de tus citas de hoy.';
      default:
        return '¿Qué vas a hacer hoy?';
    }
  }
}
