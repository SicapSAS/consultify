

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class AppointmentRoutes {



  static final routes = [
    GoRoute(
      path: '/appointment-screen',
      builder: (context, state) => const AppointmentScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final appointmentId = state.pathParameters['id'] ?? '';
            return AppointmentDetailScreen(appointmentId: appointmentId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/create-appointment-screen',
      builder: (context, state) => const CreateAppointmentScreen(),
    ),
  ];
}