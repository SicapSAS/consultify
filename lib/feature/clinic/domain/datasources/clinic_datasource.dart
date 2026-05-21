import 'package:consultify/feature/feature.dart';



abstract class ClinicDataSource {

  Future<ListClinic> createClinic(CreateClinic createClinic);

  Future<List<ListClinic>> getClinics();
}