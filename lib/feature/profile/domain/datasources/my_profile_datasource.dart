

import 'package:consultify/feature/feature.dart';

abstract class ProfileDataSource {

  Future<MyProfileEntity> getMyProfile();

}