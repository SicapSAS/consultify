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
  
  @override
  Future<bool> updatePatientStatus(String patientId, bool isActive) {
    return dataSource.updatePatientStatus(patientId, isActive);
  }
  
  @override
  Future<Patient> updatePatient(String patientId, CreatePatient updatePatient) {
    return dataSource.updatePatient(patientId, updatePatient);
  }
}