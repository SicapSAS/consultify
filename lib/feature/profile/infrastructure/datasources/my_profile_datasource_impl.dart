

import 'package:consultify/feature/feature.dart';
import 'package:dio/dio.dart';

class MyProfileDatasourceImpl implements ProfileDataSource {
  final Dio dio;

  MyProfileDatasourceImpl({required this.dio});
  
  @override
  Future<MyProfileEntity> getMyProfile() async {
    try {
      final response = await dio.get('/users/profile/me');
      
      // Mapeamos directamente la respuesta raíz usando el MyProfileMapper
      return MyProfileMapper.fromJson(response.data ?? {});
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener el perfil de usuario.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Ocurrió un error inesperado al procesar el perfil.');
    }
  }
}