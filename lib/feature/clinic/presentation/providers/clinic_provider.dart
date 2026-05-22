import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';


/* *********** Notifier Provider ************* */

final clinicProvider = StateNotifierProvider<ClinicNotifier, ClinicRepositoryState>((ref) {
  final clinicRepository = ref.watch(clinicRepositoryProvider);
  return ClinicNotifier(
    clinicRepository: clinicRepository,
  );
});


/* *********** Repository Notifier ************* */

class ClinicNotifier extends StateNotifier<ClinicRepositoryState> {
  final ClinicRepository clinicRepository;
  ClinicNotifier({
    required this.clinicRepository,
  }): super(ClinicRepositoryState()){
    getClinics();
  }

  Future<void> getClinics() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final clinics = await clinicRepository.getClinics();
      state = state.copyWith(clinics: clinics, isLoading: false, isSuccess: true);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false, isSuccess: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al obtener las clínicas', isLoading: false, isSuccess: false);
    }
  }

  Future<bool> createClinic(CreateClinic createClinic) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final clinic = await clinicRepository.createClinic(createClinic);
      state = state.copyWith(
        clinics: [...state.clinics, clinic],
        isLoading: false,
        isSuccess: true,
      );
      await getClinics();
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false, isSuccess: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al crear la clínica',
        isLoading: false,
        isSuccess: false,
      );
      return false;
    }
  }

  Future<bool> deactivateClinic(String clinicId) async {
    state = state.copyWith(errorMessage: '');
    try {
      final updatedClinic = await clinicRepository.deactivateClinic(clinicId);

      final updatedList = state.clinics.map((clinic) {
        return clinic.id == clinicId ? updatedClinic : clinic;
      }).toList();

      state = state.copyWith(
        clinics: updatedList,
        isSuccess: true,
      );

      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isSuccess: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Error al inhabilitar la clínica.',
        isSuccess: false,
      );
      return false;
    }
  }
}









/* *********** Repository State ************* */


class ClinicRepositoryState {
  final List<ListClinic> clinics;
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;

  ClinicRepositoryState({
    this.clinics = const [],
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  ClinicRepositoryState copyWith({
    List<ListClinic>? clinics,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) => ClinicRepositoryState(
    clinics: clinics ?? this.clinics,
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: errorMessage ?? this.errorMessage,
  );

}