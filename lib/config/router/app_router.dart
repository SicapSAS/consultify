import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.watch(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      /* ********** Auth Routes ********** */
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen()
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => CheckAuthStatusScreen()
      ),
      GoRoute(
        path: '/check-auth-status',
        builder: (context, state) => CheckAuthStatusScreen()
      ),

      /* ********** Home Routes ********** */
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen()
      ),
      

      







      

     
    ],
















    redirect: (context, state) {

      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;
      
      if ( authStatus == AuthStatus.notAuthenticated) {
        if ( isGoingTo == '/login' || isGoingTo  == '/create-account') return null;
        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo  == '/create-account'|| isGoingTo == '/splash') return '/home';
        return null;
      }
      return null;
    }
  );
});

