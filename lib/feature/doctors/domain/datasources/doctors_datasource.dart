
import 'package:consultify/feature/feature.dart';

abstract class DoctorsDatasource {

  Future<List<Doctor>> getDoctors();
  Future<Doctor> updateDoctor(String doctorId, DoctorUpdate doctorUpdate);
  Future<bool> deleteDoctor(String doctorId);
  Future<Doctor> createDoctor(DoctorCreate doctorCreate);
}