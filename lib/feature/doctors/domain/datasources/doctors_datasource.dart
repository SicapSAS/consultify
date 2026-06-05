
import 'package:consultify/feature/feature.dart';

abstract class DoctorsDatasource {

  Future<List<Doctor>> getDoctors();
}