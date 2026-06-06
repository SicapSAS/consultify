import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

/// Contenedor global que muestra la barra inferior en todas las rutas hijas.
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({
    super.key,
    required this.child,
  });

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  static const navRoutes = [
    '/home',
    '/profile-screen',
  ];

  static int selectedIndexForPath(String path) {
    if (path == navRoutes[1]) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;

    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      backgroundColor: AppColors.primaryBackground,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: child,
      bottomNavigationBar: Material(
        color: Colors.transparent,
        elevation: 0,
        child: CustomBottomNavigationBar(
          currentIndex: selectedIndexForPath(path),
          onTap: (_) {},
          routes: navRoutes,
        ),
      ),
    );
  }
}
