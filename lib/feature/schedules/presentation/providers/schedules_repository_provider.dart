

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schedulesRepositoryProvider = Provider<SchedulesRepository>((ref) {
  return SchedulesRepositoryImpl(
    dataSource: SchedulesDatasourceImpl(dio: ref.read(dioProvider))
  );
});