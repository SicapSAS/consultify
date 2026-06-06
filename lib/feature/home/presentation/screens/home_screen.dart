import 'package:flutter/material.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        title: AppBarLogo(
          imagePath: 'assets/logo/consultify_transparente2.png'
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => AppShell.scaffoldKey.currentState?.openDrawer(),
          icon: Icon(
            Icons.menu_rounded,
            color: AppColors.secondary,
            size: 35,
          ),
        ),
      ),
      body: _HomeBody(),
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
            height: 12,
            thickness: 1,
          ),
          Expanded(
            child: Container(),
          ),
        ]
      )
    );
  }
}
