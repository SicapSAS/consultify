import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? message;
  final String? subtitle;
  final double spinnerSize;

  const CustomLoadingWidget({
    super.key,
    this.message,
    this.subtitle,
    this.spinnerSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientSpinner(size: spinnerSize),
            const SizedBox(height: 16),
            Text(
              message ?? 'Cargando...',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle ?? 'Esto puede tardar unos segundos…',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary.withValues(alpha: 0.65),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientSpinner extends StatefulWidget {
  final double size;

  const GradientSpinner({
    super.key,
    required this.size,
  });

  @override
  State<GradientSpinner> createState() => _GradientSpinnerState();
}

class _GradientSpinnerState extends State<GradientSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thickness = widget.size * 0.1;
    final innerSize = widget.size - thickness * 2.4;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) {
          return Transform.rotate(
            angle: _ctrl.value * 6.28318,
            child: child,
          );
        },
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: SweepRingPainter(
            thickness: thickness,
            colors: [
              AppColors.infoBackground.withValues(alpha: 0.05),
              AppColors.secondaryButton.withValues(alpha: 0.45),
              AppColors.secondaryButton,
              AppColors.infoBackground.withValues(alpha: 0.15),
            ],
            stops: const [0.0, 0.35, 0.7, 1.0],
          ),
          child: Center(
            child: SizedBox(
              width: innerSize,
              height: innerSize,
              child: Icon(
                Icons.refresh_rounded,
                size: widget.size * 0.34,
                color: AppColors.secondaryButton,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
