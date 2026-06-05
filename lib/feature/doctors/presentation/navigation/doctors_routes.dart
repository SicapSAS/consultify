

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class DoctorsRoutes {



  static final routes = [
    GoRoute(
      path: '/doctors-screen',
      builder: (context, state) => DoctorsScreen()
    )
  ];
}