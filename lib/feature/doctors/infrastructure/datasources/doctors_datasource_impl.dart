

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
  
  @override
  Future<Doctor> createDoctor(DoctorCreate doctorCreate) async {
    try {
      // Serializamos los 7 campos usando el nuevo mapper
      final data = DoctorCreateMapper.toJson(doctorCreate);
      
      // Asumiendo que tu endpoint de registro sigue la convención estándar del backend
      final response = await dio.post('/doctors', data: data);
      
      // El backend registra al médico y nos devuelve el objeto poblado con su nuevo _id
      return DoctorListMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al registrar al nuevo médico.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al crear el doctor.');
    }
  }
  
  @override
  Future<bool> deleteDoctor(String doctorId) async {
    try {
      // ⚠️ NOTA: Usamos /doctors/delete/ tal cual aparece en tu Postman
      await dio.delete('/doctors/delete/$doctorId');
      return true;
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al inhabilitar al doctor.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al eliminar el doctor.');
    }
  }
  
  @override
  Future<Doctor> updateDoctor(String doctorId, DoctorUpdate doctorUpdate) async {
    try {
      final data = DoctorUpdateMapper.toJson(doctorUpdate);
      
      // ⚠️ NOTA: Usamos /doctos/update/ tal cual aparece en tu Postman
      final response = await dio.put('/doctos/update/$doctorId', data: data);
      
      return DoctorListMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al actualizar los datos del médico.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al actualizar el doctor.');
    }
  }
}