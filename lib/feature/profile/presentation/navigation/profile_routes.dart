

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class ProfileRoutes {



  static final routes = [
    GoRoute(
      path: '/profile-screen',
      builder: (context, state) => ProfileScreen()
    )
  ];
}