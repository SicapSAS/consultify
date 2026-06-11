import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/legacy.dart';


/* *********** Notifier Provider ************* */

final myProfileProvider = StateNotifierProvider<MyProfileNotifier, MyProfileRepositoryState>((ref) {
  final profileRepository = ref.watch(myProfileRepositoryProvider);
  return MyProfileNotifier(profileRepository: profileRepository);
});

/* *********** Repository Notifier ************* */

class MyProfileNotifier extends StateNotifier<MyProfileRepositoryState> {
  final ProfileRepository profileRepository;

  MyProfileNotifier({required this.profileRepository}) : super(MyProfileRepositoryState()){
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final myProfile = await profileRepository.getMyProfile();
      state = state.copyWith(myProfile: myProfile, isLoading: false, isSuccess: true, isError: false);
    } on CustomError catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false, isSuccess: false, isError: true);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error al obtener el perfil de usuario', isLoading: false, isSuccess: false, isError: true);
    }
  }
}









/* *********** Repository State ************* */


class MyProfileRepositoryState {
  final MyProfileEntity? myProfile;
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String errorMessage;

  MyProfileRepositoryState({
    this.myProfile,
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    this.errorMessage = '',
  });

  MyProfileRepositoryState copyWith({
    MyProfileEntity? myProfile,
    bool? isLoading,
    bool? isSuccess,
    bool? isError,
    String? errorMessage,
  }) => MyProfileRepositoryState(
    myProfile: myProfile ?? this.myProfile,
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    isError: isError ?? this.isError,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
