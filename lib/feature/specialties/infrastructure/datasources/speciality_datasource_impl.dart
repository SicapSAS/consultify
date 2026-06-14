

import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class SpecialityDatasourceImpl implements SpecialityDataSource {
  final Dio dio;

  SpecialityDatasourceImpl({required this.dio});
  
  @override
  Future<Specialty> createSpecialty(SpecialityCreate specialtyCreate) async {
    try {
      // 1. Crear especialidad
      final data = SpecialtyCreateMapper.toJson(specialtyCreate);
      final response = await dio.post('/specialties', data: data);
      
      return SpecialtyListMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al registrar la especialidad.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al crear especialidad.');
    }
  }
  
  @override
  Future<bool> deleteSpecialty(String specialtyId) async {
    try {
      // 5. Eliminar especialidad
      await dio.delete('/specialties/delete/$specialtyId');
      return true;
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al eliminar la especialidad.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al eliminar.');
    }
  }
  
  @override
  Future<List<Specialty>> getSpecialties() async {
    try {
      // 2. Listar todas las especialidades
      final response = await dio.get('/specialties/list');
      
      // Desempaquetamos el nodo 'specialties' según Postman
      final List<dynamic> dataList = (response.data != null && 
              response.data is Map && 
              response.data['specialties'] is List)
          ? response.data['specialties']
          : [];
          
      return dataList.map((item) => SpecialtyListMapper.fromJson(item)).toList();
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener las especialidades.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al listar especialidades.');
    }
  }
  
  @override
  Future<Specialty> toggleSpecialtyStatus(String specialtyId, SpecialityActive specialtyActive) async {
    try {
      // 4. Inhabilitar/Habilitar especialidad (Toggle)
      final data = SpecialtyActiveMapper.toJson(specialtyActive);
      final response = await dio.put('/specialties/toggle/$specialtyId', data: data);
      
        return SpecialtyListMapper.fromJson(response.data);
      } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al cambiar el estado de la especialidad.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al cambiar estado.');
    }
  }
  
  @override
  Future<Specialty> updateSpecialty(String specialtyId, SpecialityUpdate specialtyUpdate) async {
    try {
      // 3. Editar especialidad
      final data = SpecialtyUpdateMapper.toJson(specialtyUpdate);
      final response = await dio.put('/specialties/update/$specialtyId', data: data);
      
      return SpecialtyListMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al actualizar la especialidad.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al editar especialidad.');
    }
  }
}