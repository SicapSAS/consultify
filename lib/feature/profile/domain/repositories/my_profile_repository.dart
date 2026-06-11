

import 'package:consultify/feature/feature.dart';

abstract class ProfileRepository {

  Future<MyProfileEntity> getMyProfile();

}