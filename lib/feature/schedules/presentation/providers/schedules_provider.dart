import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';


/* *********** Notifier Provider ************* */

final schedulesProvider = StateNotifierProvider<ScheduleRepositoryNotifier, ScheduleRepositoryState>((ref) {
  final schedulesRepository = ref.watch(schedulesRepositoryProvider);
  return ScheduleRepositoryNotifier(schedulesRepository: schedulesRepository);
});








/* *********** Repository Notifier ************* */

class ScheduleRepositoryNotifier extends StateNotifier<ScheduleRepositoryState> {
  final SchedulesRepository schedulesRepository;
  ScheduleRepositoryNotifier({required this.schedulesRepository}) : super(ScheduleRepositoryState());

  // 🔑 MEJORA: Retorna Future<bool> para controlar limpiamente el context.pop() en la UI
  Future<bool> createDoctorSchedule(ScheduleCreate scheduleCreate) async {
    // Iniciamos la carga y limpiamos errores viejos de la pantalla
    state = state.copyWith(isLoading: true, errorMessage: '', isSuccess: false);
    
    try {
      final result = await schedulesRepository.createDoctorSchedule(scheduleCreate);
      
      state = state.copyWith(
        showSchedule: result, 
        isSuccess: true,
        isLoading: false,
        errorMessage: '', // Éxito total, nos aseguramos de vaciar el error
      );
      return true;
      
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message, 
        isSuccess: false,
        isLoading: false,
      );
      return false;
      
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Ocurrió un error inesperado al guardar la agenda del médico.', 
        isSuccess: false,
        isLoading: false,
      );
      return false;
    }
  } 
}









/* *********** Repository State ************* */


class ScheduleRepositoryState {
  final ShowSchedule? showSchedule;
  final String errorMessage;
  final bool isSuccess;
  final bool isLoading;

  ScheduleRepositoryState({
    this.showSchedule,
    this.errorMessage = '',
    this.isSuccess = false,
    this.isLoading = false,
  });

  ScheduleRepositoryState copyWith({
    ShowSchedule? showSchedule,
    String? errorMessage,
    bool? isSuccess,
    bool? isLoading,
  }) => ScheduleRepositoryState(
    showSchedule: showSchedule ?? this.showSchedule,
    errorMessage: errorMessage ?? this.errorMessage,
    isSuccess: isSuccess ?? this.isSuccess,
    isLoading: isLoading ?? this.isLoading,
  );

}