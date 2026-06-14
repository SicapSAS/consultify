import 'package:consultify/feature/feature.dart';



abstract class SpecialityDataSource {
  Future<List<Specialty>> getSpecialties();
  Future<Specialty> createSpecialty(SpecialityCreate specialtyCreate);
  Future<Specialty> updateSpecialty(String specialtyId, SpecialityUpdate specialtyUpdate);
  Future<Specialty> toggleSpecialtyStatus(String specialtyId, SpecialityActive specialtyActive);
  Future<bool> deleteSpecialty(String specialtyId);
}