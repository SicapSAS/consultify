

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clinicRepositoryProvider = Provider<ClinicRepository>((ref) {
  return ClinicRepositoryImpl(
    dataSource: ClinicDatasourceImpl(
      dio: ref.watch(dioProvider)
    )
  );
});