import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class SpecialityRoutes {
  static final routes = [
    GoRoute(
      path: '/specialties-screen',
      builder: (context, state) => const SpecialityScreen(),
    ),
  ];
}