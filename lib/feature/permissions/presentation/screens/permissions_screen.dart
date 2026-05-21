import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: CustomAppBar(
        title: 'Permisos de la aplicación',
        backRoute: '/profile-user',
      ),
      body: _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerStatefulWidget {
  const _PermissionsView();

  @override
  ConsumerState<_PermissionsView> createState() => _PermissionsViewState();
}

class _PermissionsViewState extends ConsumerState<_PermissionsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devicePermissionsProvider.notifier).checkPermissions();
    });
  }

  static String _statusLabel(bool granted) =>
      granted ? 'activado' : 'desactivado';

  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(devicePermissionsProvider);
    final horizontal = AppDimens.widthPercentage(0.05, context);
    final vertical = AppDimens.heightPercentage(0.02, context);

    return ListView(
      padding: EdgeInsets.fromLTRB(horizontal, vertical, horizontal, vertical),
      children: [
        PermissionCard(
          icon: Icons.camera_alt_rounded,
          iconColor: AppColors.secondaryButtonDark,
          title: 'Cámara',
          subtitle: _statusLabel(permissions.cameraGranted),
          value: permissions.cameraGranted,
          onChanged: (value) {
            ref.read(devicePermissionsProvider.notifier).requestCameraAccess();
          }
        ),
        SizedBox(height: AppDimens.heightPercentage(0.018, context)),
        PermissionCard(
          icon: Icons.photo_library_rounded,
          iconColor: AppColors.warningBackground,
          title: 'Galería de fotos',
          subtitle: _statusLabel(permissions.photoLibraryGranted),
          value: permissions.photoLibraryGranted,
          onChanged: (value) {
            ref.read(devicePermissionsProvider.notifier).requestPhotoLibraryAccess();
          }
        ),
        
        SizedBox(height: AppDimens.heightPercentage(0.018, context)),
        PermissionCard(
          icon: Icons.mic_rounded,
          iconColor: AppColors.successBackground,
          title: 'Microfono',
          subtitle:'En desarrollo', //_statusLabel(permissions.notificationsGranted),
          value:false, //  permissions.notificationsGranted,
          onChanged: (value) {
            //ref.read(devicePermissionsProvider.notifier).requestNotificationsAccess();
          }
        ),
        SizedBox(height: AppDimens.heightPercentage(0.018, context)),
        PermissionCard(
          icon: Icons.notifications_rounded,
          iconColor: AppColors.successBackground,
          title: 'Notificaciones',
          subtitle:'En desarrollo', //_statusLabel(permissions.notificationsGranted),
          value:false, //  permissions.notificationsGranted,
          onChanged: (value) {
            //ref.read(devicePermissionsProvider.notifier).requestNotificationsAccess();
          }
        ),
        SizedBox(height: AppDimens.heightPercentage(0.018, context)),
        PermissionCard(
          icon: Icons.record_voice_over_rounded,
          iconColor: AppColors.successBackground,
          title: 'Reconocimiento de voz',
          subtitle:'En desarrollo', //_statusLabel(permissions.notificationsGranted),
          value:false, //  permissions.notificationsGranted,
          onChanged: (value) {
            //ref.read(devicePermissionsProvider.notifier).requestNotificationsAccess();
          }
        ),
        SizedBox(height: AppDimens.heightPercentage(0.018, context)),
        PermissionCard(
          icon: Icons.location_on_rounded,
          iconColor: AppColors.successBackground,
          title: 'Ubicación',
          subtitle: _statusLabel(permissions.locationGranted),
          value: permissions.locationGranted,
          onChanged: (value) {
            ref.read(devicePermissionsProvider.notifier).requestLocationAccess();
          }
        )
      ]
    );
  }
}