import 'package:go_router/go_router.dart'; 
import 'package:consultify/feature/feature.dart';

class ClinicRoutes {



  static final routes = [
    GoRoute(
      path: '/clinic-screen',
      builder: (context, state) => ClinicScreen()
    )
  ];
}