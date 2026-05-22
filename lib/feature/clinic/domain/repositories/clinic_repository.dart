import 'package:consultify/feature/feature.dart';



abstract class ClinicRepository {

  Future<ListClinic> createClinic(CreateClinic createClinic);
  Future<List<ListClinic>> getClinics();
  Future<ListClinic> deactivateClinic(String clinicId);
}