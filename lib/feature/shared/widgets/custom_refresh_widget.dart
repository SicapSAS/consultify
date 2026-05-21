import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class CustomRefreshWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? refreshColor;
  final Color? backgroundColor;
  final bool enableRefresh;

  const CustomRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.child,
    this.refreshColor,
    this.backgroundColor,
    this.enableRefresh = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableRefresh) {
      return child;
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: refreshColor ?? AppColors.secondaryButton,
      backgroundColor: backgroundColor ?? AppColors.secondaryBackground,
      strokeWidth: 2.5,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
