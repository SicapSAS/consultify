import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            firstName.isEmpty ? 'Hola, bienvenido' : 'Hola, $firstName',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _subtitleForRole(user?.role ?? ''),
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          if (roleLabel.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.secondaryButton.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                roleLabel,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
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
