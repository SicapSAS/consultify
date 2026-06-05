

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class AppointmentRoutes {



  static final routes = [
    GoRoute(
      path: '/appointment-screen',
      builder: (context, state) => const AppointmentScreen(),
    ),
    GoRoute(
      path: '/create-appointment-screen',
      builder: (context, state) => const CreateAppointmentScreen(),
    ),
  ];
}