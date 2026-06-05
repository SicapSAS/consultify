

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepositoryImpl(
    dataSource: AppointmentDatasourceImpl(
      dio: ref.watch(dioProvider)
    )
  );
});