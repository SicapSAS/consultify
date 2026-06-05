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

  void updateFilter(AppointmentFilter filter) {
    getAppointments(filter: filter);
  }
}


/* *********** Repository State ************* */


class AppointmentRepositoryState {
  final List<AppointmentList> appointments;
  final AppointmentFilter filter;
  final String errorMessage;
  final bool isLoading;
  final bool isPosting;
  final bool hasLoadedOnce;

  AppointmentRepositoryState({
    this.appointments = const [],
    AppointmentFilter? filter,
    this.errorMessage = '',
    this.isLoading = false,
    this.isPosting = false,
    this.hasLoadedOnce = false,
  }) : filter = filter ?? AppointmentFilter.initial();

  AppointmentRepositoryState copyWith({
    List<AppointmentList>? appointments,
    AppointmentFilter? filter,
    String? errorMessage,
    bool? isLoading,
    bool? isPosting,
    bool? hasLoadedOnce,
  }) => AppointmentRepositoryState(
    appointments: appointments ?? this.appointments,
    filter: filter ?? this.filter,
    errorMessage: errorMessage ?? this.errorMessage,
    isLoading: isLoading ?? this.isLoading,
    isPosting: isPosting ?? this.isPosting,
    hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
  );
}
