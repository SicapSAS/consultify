

import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class AppointmentDatasourceImpl implements AppointmentDataSource {
  final Dio dio;

  AppointmentDatasourceImpl({required this.dio});
  
  @override
  Future<List<AppointmentList>> getAppointments(AppointmentFilter filter) async {
    try {
      // Pasamos el objeto de filtros serializado a JSON en el Body del POST
      final data = filter.toJson();
      
      final response = await dio.post('/appointments/list', data: data);
      
      // Como tu backend devuelve el arreglo directamente en la raíz de la respuesta
      final List<dynamic> dataList = response.data is List ? response.data : [];
      
      return dataList.map((item) => AppointmentListMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al cargar la agenda de citas médicas.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al procesar la agenda.');
    }
  }
}