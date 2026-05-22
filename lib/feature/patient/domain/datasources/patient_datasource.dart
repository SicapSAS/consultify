import 'package:consultify/feature/feature.dart';



abstract class PatientDataSource {

  Future<List<Patient>> getPatients();
  Future<Patient> createPatient(CreatePatient createPatient);

}