import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String?>? routes;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.routes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //if (PermissionHelper.hasPermission(ref, UserPermission.novedades))
              _buildNavItem(
                context: context,
                icon: FontAwesomeIcons.houseChimney.data,
                label: 'Inicio',
                index: 0,
                route: routes != null && routes!.isNotEmpty ? routes![0] : null,
              ),
              _buildNavItem(
                context: context,
                icon: FontAwesomeIcons.user.data,
                label: 'Perfil',
                index: 1,
                route: routes != null && routes!.length > 1 ? routes![1] : null
              )
            ]
          )
        )
      )
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    String? route,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? 
                AppColors.secondaryButton : 
                AppColors.secondary;

    return Expanded(
      child: InkWell(
        onTap: () {
          onTap(index);
          // Si hay una ruta definida, navegar a ella
          if (route != null && route.isNotEmpty) {
            context.go(route);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 22,
                )
              ]
            ),
            SizedBox(height:10),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              )
            )
          ]
        )
      )
    );
  }
}
