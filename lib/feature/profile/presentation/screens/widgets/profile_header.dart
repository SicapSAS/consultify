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
    final radius = AppDimens.widthPercentage(0.04, context);

    return Material(
      color: AppColors.secondaryBackground,
      elevation: 2,
      shadowColor: AppColors.textPrimary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(radius),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.05, context),
          vertical: AppDimens.heightPercentage(0.01, context),
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
                  fontSize: AppDimens.normalText(context),
                  fontWeight: FontWeight.bold
                )
              ),
              icon: Icon(
                Icons.logout,
                color: AppColors.textPrimary
              )
            )
          ),
          SizedBox(height: AppDimens.heightPercentage(0.02, context)),
            Row(
              children: [
                CircleAvatar(
                  radius: AppDimens.bigIcon(context),
                  backgroundColor: AppColors.secondaryButton.withValues(alpha: 0.2),
                  child: Text(
                    _initialsFromName(name),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimens.subtitleText(context)
                    )
                  )
                ),
                SizedBox(width: AppDimens.widthPercentage(0.04, context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.trim().isEmpty ? 'Usuario' : name.trim(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimens.titleText(context)
                        )
                      ),
                      SizedBox(height: AppDimens.heightPercentage(0.006, context)),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.user.data,
                            size: AppDimens.tinyIcon(context),
                            color: AppColors.textPrimary.withValues(alpha: 0.5)
                          ),
                          SizedBox(width: AppDimens.widthPercentage(0.02, context)),
                          Text(
                            'Mi cuenta',
                            style: TextStyle(
                              color: AppColors.textPrimary.withValues(alpha: 0.55),
                              fontWeight: FontWeight.w500,
                              fontSize: AppDimens.littleText(context)
                            )
                          )
                        ]
                      ),
                      SizedBox(height: AppDimens.heightPercentage(0.0, context)),
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
