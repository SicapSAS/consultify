

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class DoctorsRoutes {



  static final routes = [
    GoRoute(
      path: '/doctors-screen',
      builder: (context, state) => const DoctorsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final doctorId = state.pathParameters['id'] ?? '';
            return DoctorDetailScreen(doctorId: doctorId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/create-doctor-screen',
      builder: (context, state) {
        final doctor = state.extra as Doctor?;
        return CreateDoctorScreen(doctor: doctor);
      },
    ),
  ];
}