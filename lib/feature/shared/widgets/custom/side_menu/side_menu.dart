import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key, 
    required this.scaffoldKey
  });

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {

  String? _getCurrentRoute() {
    try {
      return GoRouterState.of(context).uri.path;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = _getCurrentRoute();
    final authState = ref.watch(authProvider);
    final userRole = authState.user?.role;

    return NavigationDrawer(
      backgroundColor: AppColors.secondaryBackground,
      elevation: 1,
      children: [
        CustomSideMenuItem(
          icon: FontAwesomeIcons.user.data,
          label: 'Mi perfil',
          isSelected: currentRoute == '/profile-user',
          route: '/profile-user',
          onTap: () {
            context.go('/profile-user');
            widget.scaffoldKey.currentState?.closeDrawer();
          },
        ),
        CustomSideMenuItem(
          icon: FontAwesomeIcons.houseChimney.data,
          label: 'Inicio',
          isSelected: currentRoute == '/home',
          route: '/home',
          onTap: () {
            context.go('/home');
            widget.scaffoldKey.currentState?.closeDrawer();
          }
        ),
        

        

        
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.widthPercentage(0.05, context),
            //vertical: AppDimens.heightPercentage(0.02, context),
          ),
          child: Divider()
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.widthPercentage(0.05, context),
            //vertical: AppDimens.heightPercentage(0.01, context),
          ),
          child: Text('Otras opciones')
        ),
        if (userRole == Roles.superAdmin)
        CustomSideMenuItem(
          icon: FontAwesomeIcons.circle.data,
          label: 'Crear clínica',
          isSelected: currentRoute == '/companies-screen',
          onTap: () {
            context.go( '/companies-screen' );
          }
        ),
        if (userRole == Roles.adminClinic)
        CustomSideMenuItem(
          icon: FontAwesomeIcons.circle.data,
          label: 'Admicion',
          isSelected: currentRoute == '/companies-screen',
          onTap: () {
            context.go( '/companies-screen' );
          }
        ),
        CustomSideMenuItem(
          icon: FontAwesomeIcons.circle.data,
          label: 'Registrar paciente',
          isSelected: currentRoute == '/companies-screen',
          onTap: () {
            context.go( '/companies-screen' );
          }
        ),
        CustomSideMenuItem(
          icon: FontAwesomeIcons.circle.data,
          label: 'Crear cita',
          isSelected: currentRoute == '/companies-screen',
          onTap: () {
            context.go( '/companies-screen' );
          }
        ),
        CustomFilledButton(
          text: 'Cerrar sesión',
          onPressed: () => ref.read(authProvider.notifier).logout()
        ),
      ]
    );
  }
}