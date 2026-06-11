
import 'package:consultify/feature/feature.dart';

abstract class DoctorsRepository {

  Future<List<Doctor>> getDoctors();
}