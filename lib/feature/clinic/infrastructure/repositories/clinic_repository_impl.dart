

import 'package:consultify/feature/feature.dart';

class ClinicRepositoryImpl implements ClinicRepository {
  final ClinicDataSource dataSource;

  ClinicRepositoryImpl({required this.dataSource});
  
  @override
  Future<ListClinic> createClinic(CreateClinic createClinic) {
    return dataSource.createClinic(createClinic);
  }
  
  @override
  Future<List<ListClinic>> getClinics() {
    return dataSource.getClinics();
  }
}