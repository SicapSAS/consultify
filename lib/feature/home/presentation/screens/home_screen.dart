import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryBackground,
        title: const AppBarLogo(
          imagePath: 'assets/logo/consultify_transparente2.png',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          HomeGreeting(),
          Expanded(child: HomeDashboard()),
        ],
      ),
    );
  }
}
