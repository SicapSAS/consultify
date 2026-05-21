import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Agrega esto para cargar el logo al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }


  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String?> _routes = [
    '/home',
    'null',
  ];

  int _getCurrentIndex() {
    final currentLocation = GoRouterState.of(context).uri.path;
    for (int i = 0; i < _routes.length; i++) {
      if (_routes[i] == currentLocation) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex();
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        title: AppBarLogo(
          imagePath: 'assets/logo/consultify_transparente2.png'
        ),
      ),
      body: _HomeBody(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {},
        routes: _routes
      )
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeGreeting(),
          //if (PermissionHelper.hasPermission(ref, UserPermission.qr))
          ShortcutsGrid(
            shortcuts: homeShortcuts(context, ref),
            crossAxisCount: 3,
            childAspectRatio: 0.9
          ),
          Divider(
            color: AppColors.secondary,
            height: AppDimens.heightPercentage(0.01, context),
            thickness: AppDimens.heightPercentage(0.001, context),
          ),
          Expanded(
            child: Container(),
          ),
        ]
      )
    );
  }
}
