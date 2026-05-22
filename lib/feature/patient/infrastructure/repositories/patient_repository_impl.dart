import 'package:consultify/feature/feature.dart';



class PatientRepositoryImpl implements PatientRepository {
  final PatientDataSource dataSource;
  PatientRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<List<Patient>> getPatients() {
    return dataSource.getPatients();
  }
  
  @override
  Future<Patient> createPatient(CreatePatient createPatient) {
    return dataSource.createPatient(createPatient);
  }
  
  @override
  Future<PatientShow> getPatientShow(String patientId) {
    return dataSource.getPatientShow(patientId);
  }
}