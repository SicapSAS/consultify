import 'package:flutter_riverpod/legacy.dart';
import 'package:consultify/feature/feature.dart';

/* *********** Notifier Provider ************* */

final specialityProvider = StateNotifierProvider<SpecialityRepositoryNotifier, SpecialityRepositoryState>((ref) {
  final specialityRepository = ref.watch(specialityRepositoryProvider);
  return SpecialityRepositoryNotifier(specialityRepository: specialityRepository);
});


/* *********** Repository Notifier ************* */

class SpecialityRepositoryNotifier extends StateNotifier<SpecialityRepositoryState> {
  final SpecialityRepository specialityRepository;

  SpecialityRepositoryNotifier({
    required this.specialityRepository,
  }) : super(SpecialityRepositoryState()) {
    // 🔑 AUTOMATIZACIÓN: Carga la lista automáticamente al inicializar el módulo
    getSpecialties();
  }

  // 📥 1. LISTAR ESPECIALIDADES
  Future<void> getSpecialties() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final specialties = await specialityRepository.getSpecialties();
      state = state.copyWith(
        specialties: specialties, 
        isLoading: false,
        errorMessage: '',
      );
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al cargar las especialidades', isLoading: false);
    }
  }

  // 🚀 2. CREAR ESPECIALIDAD
  Future<bool> createSpecialty(SpecialityCreate specialtyCreate) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final newSpecialty = await specialityRepository.createSpecialty(specialtyCreate);
      
      // Agregamos la nueva especialidad localmente de forma reactiva
      state = state.copyWith(
        specialties: [...state.specialties, newSpecialty],
        isPosting: false,
      );
      
      await getSpecialties(); // Sincronizamos con el servidor
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al crear la especialidad.', isPosting: false);
      return false;
    }
  }

  // 🔄 3. EDITAR ESPECIALIDAD
  Future<bool> updateSpecialty(String specialtyId, SpecialityUpdate specialtyUpdate) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final editedSpecialty = await specialityRepository.updateSpecialty(specialtyId, specialtyUpdate);
      
      // Buscamos y reemplazamos la especialidad modificada en la lista actual
      final updatedList = state.specialties.map((s) => s.id == specialtyId ? editedSpecialty : s).toList();
      
      state = state.copyWith(
        specialties: updatedList,
        isPosting: false,
      );
      
      await getSpecialties(); // Refrescamos de respaldo
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al actualizar la especialidad.', isPosting: false);
      return false;
    }
  }

  // 🔄 4. ALTERNAR ESTADO (TOGGLE HABILITAR/INHABILITAR)
  Future<bool> toggleSpecialtyStatus(String specialtyId, SpecialityActive specialtyActive) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      final toggledSpecialty = await specialityRepository.toggleSpecialtyStatus(specialtyId, specialtyActive);
      
      // Actualizamos el estado de la lista de manera instantánea en la UI
      final updatedList = state.specialties.map((s) => s.id == specialtyId ? toggledSpecialty : s).toList();
      
      state = state.copyWith(
        specialties: updatedList,
        isPosting: false,
      );
      
      await getSpecialties(); // Sincronizamos con el backend
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al cambiar el estado de la especialidad.', isPosting: false);
      return false;
    }
  }

  // 🗑️ 5. ELIMINAR ESPECIALIDAD
  Future<bool> deleteSpecialty(String specialtyId) async {
    state = state.copyWith(isPosting: true, errorMessage: '');
    try {
      await specialityRepository.deleteSpecialty(specialtyId);
      
      // Removemos visualmente el elemento del listado actual de inmediato
      final updatedList = state.specialties.where((s) => s.id != specialtyId).toList();
      
      state = state.copyWith(
        specialties: updatedList,
        isPosting: false,
      );
      
      await getSpecialties(); // Sincronizamos conteo total
      return true;
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isPosting: false);
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al eliminar la especialidad.', isPosting: false);
      return false;
    }
  }
}


/* *********** Repository State ************* */

class SpecialityRepositoryState {
  final List<Specialty> specialties;
  final bool isLoading;
  final bool isPosting; // 🔑 Agregado para controlar bloqueos o loaders en formularios
  final String errorMessage;

  SpecialityRepositoryState({
    this.specialties = const [],
    this.isLoading = false,
    this.isPosting = false,
    this.errorMessage = '',
  });

  SpecialityRepositoryState copyWith({
    List<Specialty>? specialties,
    bool? isLoading,
    bool? isPosting,
    String? errorMessage,
  }) => SpecialityRepositoryState(
    specialties: specialties ?? this.specialties,
    isLoading: isLoading ?? this.isLoading,
    isPosting: isPosting ?? this.isPosting,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}