import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class ClinicDatasourceImpl implements ClinicDataSource {

  final Dio dio;

  ClinicDatasourceImpl({
    required this.dio,
  });

  @override
  Future<ListClinic> createClinic(CreateClinic createClinic) async {
    try {
      // Convertimos la entidad a JSON usando su mapper dedicado antes de enviarla
      final data = CreateClinicMapper.toJson(createClinic);
      
      final response = await dio.post('/clinics', data: data);
      
      // El backend registra la clínica y nos retorna el objeto completo con su nuevo _id
      return ListClinicMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al registrar la clínica.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al crear la clínica.');
    }
  }
  
  @override
  Future<List<ListClinic>> getClinics() async {
    try {
      // Tu endpoint en Vercel mapeado en app_router es /clinics
      final response = await dio.get('/clinics/list');
      
      final List<dynamic> dataList = (response.data != null && response.data['clinics'] is List)
          ? response.data['clinics']
          : [];
      
      return dataList.map((item) => ListClinicMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener las clínicas.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al listar clínicas.');
    }
  }
  
  @override
  Future<ListClinic> deactivateClinic(String clinicId) async {
    try {
    // Petición PUT hacia tu endpoint dinámico en Vercel
    final response = await dio.put('/clinics/deactivate/$clinicId');
    
    // ListClinicMapper procesará de forma segura el nodo response.data['clinic']
    return ListClinicMapper.fromJson(response.data);
  } on DioException catch (e) {
    throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al inhabilitar la clínica.');
  } catch (e) {
    if (e is CustomError) rethrow;
    throw const CustomError(message: 'Ocurrió un error inesperado al inhabilitar la clínica.');
  }
  }
}