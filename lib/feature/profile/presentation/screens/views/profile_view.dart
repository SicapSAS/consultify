import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;

    if (user == null) {
      return Center(
        child: Text(
          'No hay sesión activa',
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            fontSize: AppDimens.normalText(context)
          )
        )
      );
    }

    final horizontalPadding = AppDimens.widthPercentage(0.06, context);
    final verticalGap = AppDimens.heightPercentage(0.02, context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        AppDimens.heightPercentage(0.02, context),
        horizontalPadding,
        AppDimens.heightPercentage(0.04, context)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          ProfileHeader(name: user.name),
          SizedBox(height: verticalGap),
          ProfileInfoTile(
            icon: FontAwesomeIcons.envelope.data,
            label: 'Correo electrónico',
            value: user.email,
          ),
          SizedBox(height: verticalGap * 0.75),
          ProfileInfoTile(
            icon: FontAwesomeIcons.idBadge.data,
            label: 'Rol',
            value: Roles.toDisplayString(user.role),
          )
        ]
      )
    );
  }
}
