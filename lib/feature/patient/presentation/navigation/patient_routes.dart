

import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class PatientRoutes {



  static final routes = [
    GoRoute(
      path: '/patient-screen',
      builder: (context, state) => PatientScreen()
    )
  ];
}