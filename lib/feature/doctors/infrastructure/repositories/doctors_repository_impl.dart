import 'package:consultify/feature/feature.dart';



class DoctorsRepositoryImpl implements DoctorsRepository {
  final DoctorsDatasource dataSource;

  DoctorsRepositoryImpl({required this.dataSource});
  
  @override
  Future<List<Doctor>> getDoctors() {
    return dataSource.getDoctors();
  }
  
  @override
  Future<Doctor> createDoctor(DoctorCreate doctorCreate) {
    return dataSource.createDoctor(doctorCreate);
  }
  
  @override
  Future<bool> deleteDoctor(String doctorId) {
    return dataSource.deleteDoctor(doctorId);
  }
  
  @override
  Future<Doctor> updateDoctor(String doctorId, DoctorUpdate doctorUpdate) {
    return dataSource.updateDoctor(doctorId, doctorUpdate);
  }
}