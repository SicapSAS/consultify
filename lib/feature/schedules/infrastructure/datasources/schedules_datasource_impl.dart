

import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class SchedulesDatasourceImpl implements SchedulesDataSource {
  final Dio dio;

  SchedulesDatasourceImpl({required this.dio});
  
  @override
  Future<ShowSchedule> createDoctorSchedule(ScheduleCreate scheduleCreate) async {
    try {
    // 🚀 Serializamos los bloques de horarios usando el nuevo mapper
    final data = ScheduleCreateMapper.toJson(scheduleCreate);
    
    // POST /doctor-schedule
    final response = await dio.post('/doctor-schedules', data: data);
    
    // 🔑 SOLUCIÓN DE RAÍZ: Usamos el método público estándar y extraemos la agenda
    return DoctorShowMapper.fromJson(response.data ?? {}).schedule;
    
  } on DioException catch (e) {
    throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al parametrizar los horarios del doctor.');
  } catch (e) {
    if (e is CustomError) rethrow;
    throw const CustomError(message: 'Ocurrió un error inesperado al guardar la agenda del médico.');
  }
  }
}