

import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class DoctorsDatasourceImpl implements DoctorsDatasource {
  final Dio dio;

  DoctorsDatasourceImpl({required this.dio});
  
  @override
  Future<List<Doctor>> getDoctors() async {
    try {
      final response = await dio.get('/doctors/list');
      
      // 🔑 Desempaquetamos de forma segura el arreglo desde la llave 'doctors'
      final List<dynamic> dataList = (response.data != null && 
              response.data is Map && 
              response.data['doctors'] is List)
          ? response.data['doctors']
          : [];
          
      return dataList.map((item) => DoctorListMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener la lista de doctores.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al listar los doctores.');
    }
  }
}