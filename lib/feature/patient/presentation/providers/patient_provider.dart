import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';


/* *********** Notifier Provider ************* */

final patientProvider = StateNotifierProvider<PatientNotifier, PatientRepositoryState>((ref) {
  final patientRepository = ref.watch(patientRepositoryProvider);
  return PatientNotifier(
    patientRepository: patientRepository,
  );
});

/* *********** Repository Notifier ************* */

class PatientNotifier extends StateNotifier<PatientRepositoryState> {
  final PatientRepository patientRepository;
  PatientNotifier({
    required this.patientRepository,
  }): super(PatientRepositoryState()) {
    getPatients();
  }

  Future<void> getPatients() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final patients = await patientRepository.getPatients();
      state = state.copyWith(
        patients: patients, 
        isLoading: false, 
        isSuccess: true,
        isError: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message, 
        isLoading: false, 
        isSuccess: false,
        isError: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al obtener los pacientes', 
        isLoading: false, 
        isSuccess: false,
        isError: true,
      );
    }
  }

  Future<bool> createPatient(CreatePatient createPatient) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final newPatient = await patientRepository.createPatient(createPatient);
      
      // Actualizamos el estado local agregando el nuevo paciente a la lista
      state = state.copyWith(
        patients: [...state.patients, newPatient],
        patient: newPatient,
        isLoading: false,
        isSuccess: true,
        isError: false,
      );
      
      // Refrescamos la lista completa para asegurar sincronización con el servidor
      await getPatients();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message, 
        isLoading: false, 
        isSuccess: false,
        isError: true,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al crear el paciente', 
        isLoading: false, 
        isSuccess: false,
        isError: true,
      );
      return false;
    }
  }

  Future<void> getPatientShow(String patientId) async {
    state = state.copyWith(isLoading: true, errorMessage: '', history: null);
    try {
      final history = await patientRepository.getPatientShow(patientId);
      state = state.copyWith(
        history: history,
        isLoading: false,
        isSuccess: true,
        isError: false,
      );
    } on CustomError catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoading: false,
        isSuccess: false,
        isError: true,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al procesar el historial médico.',
        isLoading: false,
        isSuccess: false,
        isError: true,
      );
    }
  }

  Future<bool> updatePatient(String patientId, CreatePatient updatedData) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final editedPatient = await patientRepository.updatePatient(patientId, updatedData);
      
      // Mapeamos el listado local reemplazando instantáneamente el paciente modificado
      final updatedList = state.patients.map((p) => p.id == patientId ? editedPatient : p).toList();
      
      state = state.copyWith(
        patients: updatedList,
        patient: editedPatient,
        isLoading: false,
        isSuccess: true,
        isError: false,
      );

      if (state.history?.patient.id == patientId) {
        await getPatientShow(patientId);
      }

      await getPatients();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false, isSuccess: false, isError: true);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al actualizar el paciente.', isLoading: false, isSuccess: false, isError: true);
      return false;
    }
  }

  Future<bool> updatePatientStatus(String patientId, bool isActive) async {
    state = state.copyWith(errorMessage: '');
    try {
      await patientRepository.updatePatientStatus(patientId, isActive);

      if (state.history?.patient.id == patientId) {
        await getPatientShow(patientId);
      }

      await getPatients();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false, isSuccess: false, isError: true);
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessage: isActive
            ? 'Error al habilitar el paciente.'
            : 'Error al inhabilitar el paciente.',
        isLoading: false,
        isSuccess: false,
        isError: true,
      );
      return false;
    }
  }
}









/* *********** Repository State ************* */


class PatientRepositoryState {
  final List<Patient> patients;
  final Patient? patient;
  final PatientShow? history;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String errorMessage;

  PatientRepositoryState({
    this.patients = const [],
    this.patient,
    this.history,
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage = '',
  });

  PatientRepositoryState copyWith({
    List<Patient>? patients,
    Patient? patient,
    PatientShow? history,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
  }) => PatientRepositoryState(
    patients: patients ?? this.patients,
    patient: patient ?? this.patient,
    history: history ?? this.history,
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    isError: isError ?? this.isError,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}