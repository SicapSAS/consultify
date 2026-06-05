import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CheckAuthStatusScreen extends StatefulWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  State<CheckAuthStatusScreen> createState() => _CheckAuthStatusScreenState();
}

class _CheckAuthStatusScreenState extends State<CheckAuthStatusScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (_, child) {
              return Transform.rotate(
                angle: _rotationController.value * 6.28318,
                child: child
              );
            },
            child: ClipOval(
              child: Image.asset(
                'assets/icons/consultify_icon.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover
              )
            )
          )
        )
      )
    );
  }
}
