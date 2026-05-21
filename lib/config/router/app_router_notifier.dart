

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:consultify/feature/feature.dart';

//*** Singleton - Instancia única del GoRouterNotifier ***//

final _goRouterNotifierInstance = GoRouterNotifier();

final goRouterNotifierProvider = Provider((ref){
  final authState = ref.watch(authProvider);
  _goRouterNotifierInstance.updateAuthStatus(authState.authStatus);
  return _goRouterNotifierInstance;
});

//! Notifier para actualizar el estado de autenticación

class GoRouterNotifier extends ChangeNotifier {

  //! Estado de autenticación
  AuthStatus _authStatus = AuthStatus.checking;

  //! Getter para obtener el estado de autenticación
  AuthStatus get authStatus => _authStatus;

  //! Método para actualizar el estado de autenticación
  void updateAuthStatus(AuthStatus value) {
    if (_authStatus != value) {
      _authStatus = value;
      notifyListeners();
    }
  }
}