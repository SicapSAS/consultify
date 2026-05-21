

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static  String apiUrl = dotenv.env['API_URL'] ?? 'No está configurado el API_URL';


  /*Map<String, String> createAuthorizationHeaders(String accessToken){
    return {
      'Authorization':'Bearer $accessToken'
    };
  }

  Map<String, String> createAuthorizationJsonHeaders(String accessToken){
    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }

  Map<String, String> createJsonContentTypeHeaders(){
    return {
      'Content-Type':'application/json'
    };
  }

  Map<String, String> createAuthorizationMultipartHeaders(String accessToken){
    return {
      'Authorization':'Bearer $accessToken',
      // 'Content-Type':'application/x-www-form-urlencoded',
      'Accept': 'application/json'
    }; 
  }

  Future<dynamic> getResponseData( Future<dynamic> Function() function ) async{
    try{
      return await function();
    }catch(exception, stackTrace){
      print(stackTrace);
      throw  CustomError(
        message: 'Error al obtener los datos'
      );
    }
  }

  T evaluateStatusCode<T>(int? statusCode, T response){
    if(statusCode == 200 || statusCode == 201 || statusCode == 202 || statusCode == 203 || statusCode == 205 || statusCode == 206 || statusCode == 208) {
      return response;
    } else if(statusCode == 401) {
      throw CustomError(
        message: 'Token incorrecto',
        errorCode: statusCode
      );
    } else {
      throw CustomError(
        message: 'Error al obtener los datos',
        errorCode: statusCode
      );
    }
  }

  Future<Response> executeGeneralService(Future<Response> Function() service) async {
    try {
      final response = await service();
      final statusCode = response.statusCode;
      return evaluateStatusCode<Response>(statusCode, response);
    } on DioException catch (e) {
      if ( e.response?.statusCode == 401) {
        throw CustomError(
          message: e.response?.data['message'] 
          ?? 'Token incorrecto'
          ?? 'Error al obtener los datos'
        );
      }
      if ( e.type== DioExceptionType.connectionTimeout) {
        throw CustomError(message: 'Ups!, no tienes conexión a internet');
      }
      throw Exception();
    }
  }*/

}