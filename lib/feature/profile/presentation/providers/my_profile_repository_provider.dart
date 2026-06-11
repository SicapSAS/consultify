

import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myProfileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return MyProfileRepositoryImpl(
    dataSource: MyProfileDatasourceImpl(dio: ref.read(dioProvider))
  );
});