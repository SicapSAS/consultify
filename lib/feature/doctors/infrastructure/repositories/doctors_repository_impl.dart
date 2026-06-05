

import 'package:consultify/feature/feature.dart';

class DoctorsRepositoryImpl implements DoctorsRepository {
  final DoctorsDatasource dataSource;

  DoctorsRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<Doctor>> getDoctors() {
    return dataSource.getDoctors();
  }
}