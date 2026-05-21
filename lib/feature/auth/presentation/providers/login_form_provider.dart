import 'package:formz/formz.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:consultify/feature/feature.dart';


//! 3 - StateNotifierProvider - consume afuera

final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {

   // va necesitar funcion o metodo del login
   final loginUserCallback = ref.watch(authProvider.notifier).loginUser;



  return LoginFormNotifier(
    loginUserCallback: loginUserCallback,
  );
}
);

//! 2 - Como implementamos un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({ 
    required this.loginUserCallback,
  }): super( LoginFormState());
  
  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password])
    );
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email])
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
    
    state = state.copyWith(isPosting: true);

    await loginUserCallback(state.email.value, state.password.value);
    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    final newEmail    = Email.dirty(state.email.value);
    final newPassword = Password.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: newEmail,
      password: newPassword,
      isValid: Formz.validate([newEmail, newPassword])
    );
  }
  
  onSuccess() {
    state = state.copyWith(isPosting: false, isFormPosted: true);
  }
  
  /*onError(String error) {
    state = state.copyWith(isPosting: false, isFormPosted: true);
  }*/
}

//! 1 - State del Provider
class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );


  @override
  String toString() {
    return '''
  LoginFormState:
  isPosting: $isPosting
  isFormPosted: $isFormPosted
  isValid: $isValid
  email: $email
  password: $password
''';
  }
}








