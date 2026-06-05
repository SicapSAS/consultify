import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? message;
  final String? subtitle;
  const CustomLoadingWidget({
    super.key,
    this.message,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            size.width * 0.04
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 14, 
              sigmaY: 14
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  size.width * 0.04
                )
              ),
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.03,
                horizontal: size.width * 0.06
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientSpinner(size: size.width * 0.18),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    message ?? 'Cargando...',
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.04,
                      letterSpacing: 0.2
                    )
                  ),
                  SizedBox(height: size.height * 0.006),
                  Opacity(
                    opacity: 0.75,
                    child: Text(
                      subtitle ?? 'Esto puede tardar unos segundos…',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}

class GradientSpinner extends StatefulWidget {
  final double size;

  const GradientSpinner({
    super.key, 
    required this.size
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
      duration: Duration(seconds: 2)
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final thickness = size.width * 0.12;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) {
          return Transform.rotate(
            angle: _ctrl.value * 6.28318,
            child: child
          );
        },
        child: CustomPaint(
          painter: SweepRingPainter(
            thickness: thickness,
            colors: [
              AppColors.infoBackground.withValues(alpha: 0.15),
              AppColors.primary,
              AppColors.infoBackground.withValues(alpha: 0.15)
            ]
          ),
          child: Center(
            child: Container(
              width:  thickness * 2.2,
              height: thickness * 2.2,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.65),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 2,
                    spreadRadius: 1
                  )
                ]
              ),
              child: Icon(
                Icons.refresh_rounded,
                size: 25,
                color: AppColors.iconDark
              )
            )
          )
        )
      )
    );
  }
}