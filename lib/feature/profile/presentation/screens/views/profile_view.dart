import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authProvider).user;
    final state = ref.watch(myProfileProvider);

    if (authUser == null) {
      return Center(
        child: Text(
          'No hay sesión activa',
          style: TextStyle(
            color: AppColors.textPrimary.withValues(alpha: 0.6),
            fontSize: 18,
          ),
        ),
      );
    }

    if (state.isLoading && state.myProfile == null) {
      return const CustomLoadingWidget(
        message: 'Cargando tu perfil...',
        subtitle: 'Obteniendo tus datos de cuenta',
      );
    }

    if (state.isError && state.myProfile == null) {
      return CustomErrorStateWidget(
        message: state.errorMessage,
        onRetry: () => ref.read(myProfileProvider.notifier).getMyProfile(),
      );
    }

    final profile = state.myProfile;
    if (profile == null) {
      return CustomEmptyStateWidget(
        message: 'No se encontró información del perfil',
        icon: FontAwesomeIcons.user.data,
        iconColor: AppColors.secondary.withValues(alpha: 0.5),
      );
    }

    return CustomRefreshableContent(
      onRefresh: () => ref.read(myProfileProvider.notifier).getMyProfile(),
      isRefreshing: state.isLoading,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          16,
          12,
          16,
          CustomBottomNavigationBar.scrollBottomPadding(context),
        ),
        children: [
          ProfileHeader(
            name: profile.name,
            roleLabel: ProfileDetailsSections.roleLabel(profile),
            isActive: profile.isActive,
          ),
          const SizedBox(height: 20),
          ProfileDetailsSections(profile: profile),
        ],
      ),
    );
  }
}
