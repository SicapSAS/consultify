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

  void _navigateAndClose(VoidCallback navigation) {
    navigation();
    widget.scaffoldKey.currentState?.closeDrawer();
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
        
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Image.asset(
            'assets/logo/consultify_transparente2.png',
            width: 100,
            fit: BoxFit.contain
          )
        ),
        SizedBox(height: 15),
        CustomSideMenuSectionTitle(label: 'Mi cuenta'),
        CustomSideMenuItem(
          icon: FontAwesomeIcons.user.data,
          label: 'Perfil',
          isSelected: currentRoute == '/profile-screen',
          onTap: () => _navigateAndClose(() => context.go('/profile-screen')),
        ),
        CustomSideMenuSectionTitle(label: 'Opcion principal'),
        CustomSideMenuItem(
          icon: FontAwesomeIcons.houseChimney.data,
          label: 'Inicio',
          isSelected: currentRoute == '/home',
          route: '/home',
          onTap: () => _navigateAndClose(() => context.go('/home')),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Divider()
        ),

        

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Divider()
        ),

        if (userRole == Roles.superAdmin) ...[  
          CustomSideMenuSectionTitle(label: 'Empresas'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.building.data,
            label: 'Clínicas',
            isSelected: currentRoute == '/clinic-screen',
            onTap: () => _navigateAndClose(() => context.go('/clinic-screen')),
          )
        ],
        if (userRole == Roles.adminClinic) ...[
          CustomSideMenuItem(
            icon: FontAwesomeIcons.userDoctor.data,
            label: 'Admiciones',
            isSelected: currentRoute == '',
            onTap: () => _navigateAndClose(() => context.go('/')),
          ),
          CustomSideMenuSectionTitle(label: 'Doctores'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.userDoctor.data,
            label: 'Doctores',
            isSelected: currentRoute == '/doctors-screen',
            onTap: () => _navigateAndClose(() => context.go('/doctors-screen')),
          ),
          CustomSideMenuSectionTitle(label: 'Especialidades'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.stethoscope.data,
            label: 'Especialidades',
            isSelected: currentRoute == '/specialties-screen',
            onTap: () => _navigateAndClose(() => context.go('/specialties-screen')),
          ),
          CustomSideMenuSectionTitle(label: 'Configuración'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.gear.data,
            label: 'Horarios',
            isSelected: currentRoute == '/schedules-screen',
            onTap: () => _navigateAndClose(() => context.go('/schedules-screen')),
          ),
        ]
      ]
    );
  }
}