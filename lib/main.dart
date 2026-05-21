import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Environment.initEnvironment();
  runApp(
    ProviderScope(
      child: const MainApp()
    )
  );
}  

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(devicePermissionsProvider.notifier).checkPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    print('state: $state');
    ref.read( appStateProvider.notifier).state = state;
    if ( state == AppLifecycleState.resumed ) {
      ref.read(devicePermissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(goRouterProvider),
      supportedLocales: AppLocaleConfig.supportedLocales,
      localizationsDelegates: AppLocaleConfig.localizationsDelegates,
      locale: const Locale('es'),
    );
  }
}