import 'package:consultify/feature/feature.dart';



abstract class PatientDataSource {

  Future<List<Patient>> getPatients();
  Future<Patient> createPatient(CreatePatient createPatient);
  Future<PatientShow> getPatientShow(String patientId);
  Future<Patient> updatePatient(String patientId, CreatePatient updatePatient);
  Future<bool> updatePatientStatus(String patientId, bool isActive);

}