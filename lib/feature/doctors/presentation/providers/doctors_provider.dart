import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';

/* *********** Notifier Provider ************* */

final doctorsProvider = StateNotifierProvider<DoctorNotifier, DoctorRepositoryState>((ref) {
  final doctorsRepository = ref.watch(doctorsRepositoryProvider);
  return DoctorNotifier(
    doctorsRepository: doctorsRepository,
  );
});

/* *********** Repository Notifier ************* */

class DoctorNotifier extends StateNotifier<DoctorRepositoryState> {
  // Asegúrate de que el tipo coincida con tu interfaz abstracta (DoctorsRepository)
  final DoctorsRepository doctorsRepository;

  DoctorNotifier({
    required this.doctorsRepository,
  }) : super(DoctorRepositoryState()) {
    // 🔑 CORRECCIÓN CRÍTICA: Disparar la carga automática apenas entra al módulo
    getDoctors();
  }

  Future<void> getDoctors() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final doctors = await doctorsRepository.getDoctors();
      state = state.copyWith(
        doctors: doctors, 
        isLoading: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al cargar los doctores', isLoading: false);
    }
  }
}

/* *********** Repository State ************* */

class DoctorRepositoryState {
  final List<Doctor> doctors;
  final bool isLoading;
  final String errorMessage;
  final bool isPosting;

  DoctorRepositoryState({
    this.doctors = const [],
    this.isLoading = false,
    this.errorMessage = '',
    this.isPosting = false,
  });

  DoctorRepositoryState copyWith({
    List<Doctor>? doctors,
    bool? isLoading,
    String? errorMessage,
    bool? isPosting,
  }) => DoctorRepositoryState(
    doctors: doctors ?? this.doctors,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    isPosting: isPosting ?? this.isPosting,
  );
}