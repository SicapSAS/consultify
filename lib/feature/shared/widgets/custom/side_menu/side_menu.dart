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
    final size = MediaQuery.of(context).size;
    final currentRoute = _getCurrentRoute();
    final authState = ref.watch(authProvider);
    final userRole = authState.user?.role;

    return NavigationDrawer(
      backgroundColor: AppColors.secondaryBackground,
      elevation: 1,
      children: [
        
        SizedBox(height: size.height * 0.03),
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
        CustomSideMenuSectionTitle(label: 'Opcion principal'),
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
            horizontal: size.width * 0.05,
            //vertical: AppDimens.heightPercentage(0.02, context),
          ),
          child: Divider()
        ),

        if (userRole == Roles.superAdmin) ...[  
          CustomSideMenuSectionTitle(label: 'Empresas'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.building.data,
            label: 'Clínicas',
            isSelected: currentRoute == '/clinic-screen',
            onTap: () {
              context.push('/clinic-screen');
              widget.scaffoldKey.currentState?.closeDrawer();
            }
          )
        ],
        if (userRole == Roles.adminClinic) ...[
          CustomSideMenuSectionTitle(label: 'Citas'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.calendarCheck.data,
            label: 'Nueva cita',
            isSelected: currentRoute == '/companies-screen',
            onTap: () {
              context.go( '/companies-screen' );
            }
          ),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.calendarDays.data,
            label: 'Agendas',
            isSelected: currentRoute == '/companies-screen',
            onTap: () {
              context.go( '/companies-screen' );
              widget.scaffoldKey.currentState?.closeDrawer();
            }
          ),
          CustomSideMenuSectionTitle(label: 'Pacientes'),
          CustomSideMenuItem(
            icon: Icons.person_add_alt_1_outlined,
            label: 'Pacientes',
            isSelected: currentRoute == '/patient-screen',
            onTap: () {
              context.push( '/patient-screen' );
              widget.scaffoldKey.currentState?.closeDrawer();
            }
          ),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.userPlus.data,
            label: 'Admiciones',
            isSelected: currentRoute == '/create-patient-screen',
            onTap: () {
              context.push('/create-patient-screen');
              widget.scaffoldKey.currentState?.closeDrawer();
            }
          ),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.userDoctor.data,
            label: 'Atenciones',
            isSelected: currentRoute == '/companies-screen',
            onTap: () {
              context.go( '/companies-screen' );
            }
          ),
          CustomSideMenuSectionTitle(label: 'Configuración'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.gear.data,
            label: 'Parametrizar',
            isSelected: currentRoute == '/companies-screen',
            onTap: () {
              context.go( '/companies-screen' );
            }
          ),
          CustomSideMenuSectionTitle(label: 'Doctores'),
          CustomSideMenuItem(
            icon: FontAwesomeIcons.userDoctor.data,
            label: 'Doctores',
            isSelected: currentRoute == '/companies-screen',
            onTap: () {
              context.go( '/companies-screen' );
            }
          )
        ]
      ]
    );
  }
}