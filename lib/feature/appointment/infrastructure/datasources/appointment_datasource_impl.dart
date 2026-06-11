import 'package:dio/dio.dart';
import 'package:consultify/feature/feature.dart';



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
  
  @override
  Future<AppointmentShow> attendAppointment(String id, AppointmentAttend attend) async {
    try {
      // PUT /appointments/:id/attend
      final response = await dio.put('/appointments/$id/attend', data: attend.toJson());
      return AppointmentShowMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al registrar la evolución de la cita.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al registrar evolución.');
    }
  }
  
  @override
  Future<AppointmentShow> cancelAppointment(String id, AppointmentCancel cancel) async {
    try {
      // PUT /appointments/:id/cancel
      final response = await dio.put('/appointments/$id/cancel', data: cancel.toJson());
      return AppointmentShowMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al procesar la cancelación.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al cancelar.');
    }
  }
  
  @override
  Future<AppointmentShow> createAppointment(AppointmentCreate appointmentCreate) async {
    try {
      // POST /appointments
      final data = AppointmentCreateMapper.toJson(appointmentCreate);
      final response = await dio.post('/appointments', data: data);
      return AppointmentShowMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al reservar la cita médica.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al agendar.');
    }
  }
  
  @override
  Future<AppointmentShow> getAppointmentById(String id) async {
    try {
      // GET /appointments/:id
      final response = await dio.get('/appointments/$id');
      return AppointmentShowMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al obtener el detalle de la cita.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al consultar la cita.');
    }
  }
  
  @override
  Future<AppointmentShow> updateAppointmentStatus(String id, AppointmentStatus status) async {
    try {
      // PUT /appointments/:id/status
      final data = AppointmentStatusMapper.toJson(status);
      final response = await dio.put('/appointments/$id/status', data: data);
      return AppointmentShowMapper.fromJson(response.data);
    } on DioException catch (e) {
      throw DioErrorMapper.fromDioException(e, mensajeFallback: 'Error al actualizar el estado/pago.');
    } catch (e) {
      if (e is CustomError) rethrow;
      throw const CustomError(message: 'Error inesperado al actualizar estado.');
    }
  }
}