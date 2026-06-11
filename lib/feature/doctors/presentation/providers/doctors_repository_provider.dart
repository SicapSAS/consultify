

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorsRepositoryProvider = Provider<DoctorsRepository>((ref) {
  return DoctorsRepositoryImpl(
    dataSource: DoctorsDatasourceImpl(
      dio: ref.watch(dioProvider)
    )
  );
});