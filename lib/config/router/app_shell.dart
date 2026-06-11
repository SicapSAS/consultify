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
    '/appointment-screen',
    '/patient-screen',
  ];

  /// Índice activo del bottom nav. -1 si la ruta no pertenece a la barra.
  static int selectedIndexForPath(String path) {
    if (path == '/home') return 0;
    if (path.startsWith('/appointment-screen') || path == '/create-appointment-screen') {
      return 1;
    }
    if (path.startsWith('/patient-screen') || path == '/create-patient-screen') {
      return 2;
    }
    return -1;
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
