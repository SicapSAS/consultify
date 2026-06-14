

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final specialityRepositoryProvider = Provider<SpecialityRepository>((ref) {
  return SpecialityRepositoryImpl(
    dataSource: SpecialityDatasourceImpl(
      dio: ref.read(dioProvider)
    )
  );
});