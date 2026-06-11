

import 'package:consultify/feature/feature.dart';

class MyProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  MyProfileRepositoryImpl({required this.dataSource});
  
  @override
  Future<MyProfileEntity> getMyProfile() {
    return dataSource.getMyProfile();
  }
}