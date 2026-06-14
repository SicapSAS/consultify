

import 'package:consultify/feature/feature.dart';

class SpecialityRepositoryImpl implements SpecialityRepository {
  final SpecialityDataSource dataSource;

  SpecialityRepositoryImpl({required this.dataSource});
  
  @override
  Future<Specialty> createSpecialty(SpecialityCreate specialtyCreate) {
    return dataSource.createSpecialty(specialtyCreate);
  }
  
  @override
  Future<bool> deleteSpecialty(String specialtyId) {
    return dataSource.deleteSpecialty(specialtyId);
  }
  
  @override
  Future<List<Specialty>> getSpecialties() {
    return dataSource.getSpecialties();
  }
  
  @override
  Future<Specialty> toggleSpecialtyStatus(String specialtyId, SpecialityActive specialtyActive) {
    return dataSource.toggleSpecialtyStatus(specialtyId, specialtyActive);
  }
  
  @override
  Future<Specialty> updateSpecialty(String specialtyId, SpecialityUpdate specialtyUpdate) {
    return dataSource.updateSpecialty(specialtyId, specialtyUpdate);
  }
}