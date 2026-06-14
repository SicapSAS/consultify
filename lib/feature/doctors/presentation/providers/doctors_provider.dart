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

  // 🚀 2. CREAR DOCTOR
  Future<bool> createDoctor(DoctorCreate doctorCreate) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final newDoctor = await doctorsRepository.createDoctor(doctorCreate);
      
      // Agregamos el nuevo doctor al estado de forma inmutable
      state = state.copyWith(
        doctors: [...state.doctors, newDoctor],
        isPosting: false,
      );
      
      await getDoctors(); // Sincronizamos con el backend
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al crear el médico.', isPosting: false);
      return false;
    }
  }

  // 🔄 3. ACTUALIZAR DOCTOR
  Future<bool> updateDoctor(String doctorId, DoctorUpdate doctorUpdate) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final editedDoctor = await doctorsRepository.updateDoctor(doctorId, doctorUpdate);

      final updatedList =
          state.doctors.map((d) => d.id == doctorId ? editedDoctor : d).toList();

      state = state.copyWith(
        doctors: updatedList,
        isPosting: false,
      );

      await getDoctors();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al actualizar el médico.', isPosting: false);
      return false;
    }
  }

  Future<bool> updateDoctorStatus(String doctorId, bool isActive) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      await doctorsRepository.updateDoctorStatus(doctorId, isActive);
      await getDoctors();
      state = state.copyWith(isPosting: false);
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessage: isActive
            ? 'Error al habilitar el doctor.'
            : 'Error al inhabilitar el doctor.',
        isPosting: false,
      );
      return false;
    }
  }

  // 🗑️ 4. ELIMINAR DOCTOR
  Future<bool> deleteDoctor(String doctorId) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      await doctorsRepository.deleteDoctor(doctorId);
      
      // Eliminamos de la lista local de forma inmediata
      final updatedList = state.doctors.where((d) => d.id != doctorId).toList();
      
      state = state.copyWith(
        doctors: updatedList,
        isPosting: false,
      );
      
      await getDoctors(); // Sincronizamos con el conteo de la nube
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al eliminar el médico.', isPosting: false);
      return false;
    }
  }

  // 🔑 NUEVO MÉTODO: Consultar perfil detallado y horarios del doctor
  Future<void> getDoctorById(String doctorId) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: '',
      selectedDoctor: null,
    );
    try {
      final doctorShow = await doctorsRepository.getDoctorById(doctorId);
      state = state.copyWith(selectedDoctor: doctorShow, isLoading: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al obtener el horario del médico.', isLoading: false);
    }
  }
  
}

/* *********** Repository State ************* */

class DoctorRepositoryState {
  final List<Doctor> doctors;
  final DcotorShow? selectedDoctor;
  final bool isLoading;
  final String errorMessage;
  final bool isPosting;

  DoctorRepositoryState({
    this.doctors = const [],
    this.selectedDoctor,
    this.isLoading = false,
    this.errorMessage = '',
    this.isPosting = false,
  });

  DoctorRepositoryState copyWith({
    List<Doctor>? doctors,
    DcotorShow? selectedDoctor,
    bool? isLoading,
    String? errorMessage,
    bool? isPosting,
  }) => DoctorRepositoryState(
    doctors: doctors ?? this.doctors,
    selectedDoctor: selectedDoctor ?? this.selectedDoctor,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
    isPosting: isPosting ?? this.isPosting,
  );
}