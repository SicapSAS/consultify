import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.watch(goRouterNotifierProvider);
  
  // 1. Escuchamos de forma reactiva el estado de autenticación para obtener al usuario y su rol
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      /* ********** Auth Routes ********** */
      GoRoute(
        path: '/login',
        builder: (context, state) =>  LoginScreen()
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen()
      ),
      GoRoute(
        path: '/check-auth-status',
        builder: (context, state) => const CheckAuthStatusScreen()
      ),

      /* ********** Home Routes ********** */
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen()
      ),
      /* ********** Profile Routes ********** */
      ...ProfileRoutes.routes,

      /* ********** Clinic Routes ********** */
      ...ClinicRoutes.routes,

      /* ********** Patient Routes ********** */
      ...PatientRoutes.routes,

      /* ********** Appointment Routes ********** */
      ...AppointmentRoutes.routes,
    ],







    redirect: (context, state) {
      final isGoingTo = state.uri.path;
      final authStatus = goRouterNotifier.authStatus;

      // Si apenas está cargando la app validando el token, mantener en splash
      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;
      
      // 2. Control para usuarios No Autenticados
      if ( authStatus == AuthStatus.notAuthenticated) {
        if ( isGoingTo == '/login' || isGoingTo == '/create-account') return null;
        return '/login';
      }

      // 3. Control para usuarios Autenticados
      if ( authStatus == AuthStatus.authenticated ) {
        // Si ya está logueado e intenta ir a login o splash, redirigir
        if ( isGoingTo == '/login' || isGoingTo == '/create-account' || isGoingTo == '/splash') {
          return '/home';
        }
        
        // 4. 🔒 GUARDIÁN DE ROLES (PROTEGER SUB-RUTAS ESPECÍFICAS)
        // Ejemplo: Si intenta entrar a una pantalla del módulo de clínicas (ej: /clinics, /clinics/create)
        // pero su rol NO es el de Super Administrador, lo bloqueamos y lo regresamos al home seguro.
        if (isGoingTo.startsWith('/clinics') && authState.user?.role != Roles.superAdmin) {
          return '/home'; 
        }

        // Ejemplo B: Si creas una sub-ruta exclusiva para odontólogos (ej: /professional/clinical-history)
        if (isGoingTo.startsWith('/professional') && authState.user?.role != Roles.professional) {
          return '/home';
        }
        
        return null;
      }
      
      return null;
    }
  );
});