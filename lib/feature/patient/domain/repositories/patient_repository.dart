import 'package:consultify/feature/feature.dart';



abstract class PatientRepository {

  Future<List<Patient>> getPatients();
  Future<Patient> createPatient(CreatePatient createPatient);
  Future<PatientShow> getPatientShow(String patientId);

}