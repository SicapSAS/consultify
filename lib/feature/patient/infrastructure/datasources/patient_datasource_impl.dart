import 'package:dio/dio.dart';
import 'package:consultify/feature/feature.dart';



class PatientDatasourceImpl implements PatientDataSource {

  final Dio dio;

  PatientDatasourceImpl({
    required this.dio,
  });
  
  @override
  Future<Patient> createPatient(CreatePatient createPatient) async {
    try {
      final data = CreatePatientMapper.toJson(createPatient);
      final response = await dio.post('/patients', data: data);
      
      // Mapeamos el paciente devuelto de forma directa o desempaquetada
      return ListPatientMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al registrar al paciente.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al registrar el paciente.');
    }
  }
  
  @override
  Future<List<Patient>> getPatients() async {
    try {
      final response = await dio.get('/patients/list');
      
      // 🔑 Desempaquetamos la lista desde la propiedad 'patients' según tu Postman
      final List<dynamic> dataList = (response.data != null && 
              response.data is Map && 
              response.data['patients'] is List)
          ? response.data['patients']
          : [];
          
      return dataList.map((item) => ListPatientMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener los pacientes.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al listar los pacientes.');
    }
  }
  
  @override
  Future<PatientShow> getPatientShow(String patientId) async {
    try {
    // Petición al endpoint dinámico de Vercel
    final response = await dio.get('/patients/appointments/history/$patientId');
    
    // Mapeamos el mapa JSON directamente con el mapeador especializado
    return PatientShowMapper.fromJson(response.data ?? {});
  } on DioException catch (e) {
    throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener el historial del paciente.');
  } catch (e) {
    if (e is CustomError) rethrow;
    throw const CustomError(message: 'Ocurrió un error inesperado al procesar el historial.');
  }
  }

}