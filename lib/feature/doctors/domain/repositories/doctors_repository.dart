
import 'package:consultify/feature/feature.dart';

abstract class DoctorsRepository {

  Future<List<Doctor>> getDoctors();
  Future<Doctor> updateDoctor(String doctorId, DoctorUpdate doctorUpdate);
  Future<Doctor> updateDoctorStatus(String doctorId, bool isActive);
  Future<bool> deleteDoctor(String doctorId);
  Future<Doctor> createDoctor(DoctorCreate doctorCreate);
  Future<DcotorShow> getDoctorById(String doctorId);
}