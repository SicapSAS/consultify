import 'package:consultify/feature/feature.dart';
import 'package:go_router/go_router.dart';

class SchedulesRoutes {
  static final routes = [
    GoRoute(
      path: '/schedules-screen',
      builder: (context, state) => const SchedulesScreen(),
    ),
    GoRoute(
      path: '/create-schedule-screen',
      builder: (context, state) {
        final doctor = state.extra as Doctor?;
        return CreateScheduleScreen(doctor: doctor);
      },
    ),
  ];
}
