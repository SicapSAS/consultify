import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';


/* *********** Notifier Provider ************* */

final appointmentProvider = StateNotifierProvider<AppointmentNotifier, AppointmentRepositoryState>((ref) {
  final appointmentRepository = ref.watch(appointmentRepositoryProvider);
  return AppointmentNotifier(appointmentRepository: appointmentRepository);
});


/* *********** Repository Notifier ************* */

class AppointmentNotifier extends StateNotifier<AppointmentRepositoryState> {
  final AppointmentRepository appointmentRepository;

  AppointmentNotifier({
    required this.appointmentRepository,
  }) : super(AppointmentRepositoryState());

  Future<void> getAppointments({AppointmentFilter? filter}) async {
    final activeFilter = filter ?? state.filter;
    state = state.copyWith(
      isLoading: true,
      filter: activeFilter,
      errorMessage: '',
    );

    try {
      final appointments = await appointmentRepository.getAppointments(activeFilter);
      state = state.copyWith(
        appointments: appointments,
        isLoading: false,
        errorMessage: '',
        hasLoadedOnce: true,
        filter: activeFilter,
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al cargar las citas',
        isLoading: false,
        hasLoadedOnce: true,
        filter: activeFilter,
      );
    }
  }

  // 🔎 Consultar el detalle completo de una cita específica por ID
  Future<void> getAppointmentById(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final appointment = await appointmentRepository.getAppointmentById(id);
      state = state.copyWith(selectedAppointment: appointment, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al cargar el detalle de la cita.', isLoading: false);
    }
  }

  // 📝 Crear una nueva cita e inmediatamente refrescar la agenda del mes
  Future<bool> createAppointment(AppointmentCreate appointmentCreate) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      await appointmentRepository.createAppointment(appointmentCreate);
      state = state.copyWith(isPosting: false);
      await getAppointments(); // Refrescar vista
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al agendar la cita.', isPosting: false);
      return false;
    }
  }

  // 🔄 Actualizar estados de pago o re-agendar fecha/hora
  Future<bool> updateAppointmentStatus(String id, AppointmentStatus status) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final updated = await appointmentRepository.updateAppointmentStatus(id, status);
      state = state.copyWith(selectedAppointment: updated, isPosting: false);
      await getAppointments(); // Sincronizar UI del calendario
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al modificar la cita.', isPosting: false);
      return false;
    }
  }

  // 🩺 Registrar atención médica y finalizar la consulta
  Future<bool> attendAppointment(String id, AppointmentAttend attend) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final updated = await appointmentRepository.attendAppointment(id, attend);
      state = state.copyWith(selectedAppointment: updated, isPosting: false);
      await getAppointments();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al registrar atención.', isPosting: false);
      return false;
    }
  }

  // ❌ Cancelar cita médica con motivo
  Future<bool> cancelAppointment(String id, AppointmentCancel cancel) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final updated = await appointmentRepository.cancelAppointment(id, cancel);
      state = state.copyWith(selectedAppointment: updated, isPosting: false);
      await getAppointments();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al cancelar la cita.', isPosting: false);
      return false;
    }
  }

  void updateFilter(AppointmentFilter filter) {
    getAppointments(filter: filter);
  }

}


/* *********** Repository State ************* */


class AppointmentRepositoryState {
  final List<AppointmentList> appointments;
  final AppointmentShow? selectedAppointment;
  final AppointmentFilter filter;
  final String errorMessage;
  final bool isLoading;
  final bool isPosting;
  final bool hasLoadedOnce;

  AppointmentRepositoryState({
    this.appointments = const [],
    this.selectedAppointment,
    AppointmentFilter? filter,
    this.errorMessage = '',
    this.isLoading = false,
    this.isPosting = false,
    this.hasLoadedOnce = false,
  }) : filter = filter ?? AppointmentFilter.initial();

  AppointmentRepositoryState copyWith({
    List<AppointmentList>? appointments,
    AppointmentShow? selectedAppointment,
    AppointmentFilter? filter,
    String? errorMessage,
    bool? isLoading,
    bool? isPosting,
    bool? hasLoadedOnce,
  }) => AppointmentRepositoryState(
    appointments: appointments ?? this.appointments,
    selectedAppointment: selectedAppointment ?? this.selectedAppointment,
    filter: filter ?? this.filter,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
    isPosting: isPosting ?? this.isPosting,
    hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
  );
}
