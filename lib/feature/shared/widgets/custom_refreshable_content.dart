import 'package:consultify/config/config.dart';
import 'package:flutter/material.dart';


class CustomRefreshableContent extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final bool isRefreshing;
  final bool enableRefresh;
  final Color? refreshColor;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? progressBackgroundColor;

  const CustomRefreshableContent({
    super.key,
    required this.onRefresh,
    required this.child,
    this.isRefreshing = false,
    this.enableRefresh = true,
    this.refreshColor,
    this.backgroundColor,
    this.progressColor,
    this.progressBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!enableRefresh) {
      return _buildWithProgressOverlay(child);
    }

    return _buildWithProgressOverlay(
      RefreshIndicator(
        onRefresh: onRefresh,
        color: refreshColor ?? AppColors.secondaryButton,
        backgroundColor: backgroundColor ?? AppColors.secondaryBackground,
        strokeWidth: 2.5,
        child: child
      )
    );
  }

  Widget _buildWithProgressOverlay(Widget content) {
    if (!isRefreshing) return content;

    return Stack(
      children: [
        content,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: LinearProgressIndicator(
            color: progressColor ?? AppColors.secondaryButton,
            backgroundColor: progressBackgroundColor ??
                AppColors.secondaryButton.withValues(alpha: 0.2)
          )
        )
      ]
    );
  }
}
