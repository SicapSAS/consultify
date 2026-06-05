

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class PatientRoutes {



  static final routes = [
    GoRoute(
      path: '/patient-screen',
      builder: (context, state) => const PatientScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final patientId = state.pathParameters['id'] ?? '';
            return PatientDetailScreen(patientId: patientId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/create-patient-screen',
      builder: (context, state) {
        final patient = state.extra as Patient?;
        return CreatePatientScreen(patient: patient);
      },
    ),
  ];
}