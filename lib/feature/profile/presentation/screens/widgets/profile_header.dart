import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileHeader extends ConsumerWidget {
  final String name;

  const ProfileHeader({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final radius = size.width * 0.04;

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        child: Column(
          children: [Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => ref.read(authProvider.notifier).logout(), 
              label: Text(
                'Cerrar sesión',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold
                )
              ),
              icon: Icon(
                Icons.logout,
                color: AppColors.textPrimary
              )
            )
          ),
          SizedBox(height: size.height * 0.02),
            Row(
              children: [
                CircleAvatar(
                  radius: size.width * 0.08,
                  backgroundColor: AppColors.secondaryButton.withValues(alpha: 0.2),
                  child: Text(
                    _initialsFromName(name),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.04
                    )
                  )
                ),
                SizedBox(width: size.width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.trim().isEmpty ? 'Usuario' : name.trim(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.04
                        )
                      ),
                      SizedBox(height: size.height * 0.006),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user.data,
                            size: size.width * 0.08,
                            color: AppColors.textPrimary.withValues(alpha: 0.5)
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            'Mi cuenta',
                            style: TextStyle(
                              color: AppColors.textPrimary.withValues(alpha: 0.55),
                              fontWeight: FontWeight.w500,
                              fontSize: size.width * 0.03
                            )
                          )
                        ]
                      ),
                      SizedBox(height: size.height * 0.008),
                    ]
                  )
                )
              ]
            ),
          ],
        )
      )
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
