import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.watch(authProvider).user;

    if (user == null) {
      return Center(
        child: Text(
          'No hay sesión activa',
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            fontSize: size.width * 0.04
          )
        )
      );
    }

    final horizontalPadding = size.width * 0.06;
    final verticalGap = size.height * 0.02;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        size.height * 0.02,
        horizontalPadding,
        size.height * 0.04
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
