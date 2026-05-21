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
      final response = await dio.get('/clinics');
      
      // Como tu backend devuelve el arreglo directamente en el cuerpo raíz de la respuesta:
      final List<dynamic> dataList = response.data is List ? response.data : [];
      
      return dataList.map((item) => ListClinicMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener las clínicas.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al listar clínicas.');
    }
  }
}