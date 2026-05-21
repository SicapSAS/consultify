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
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.widthPercentage(0.08, context)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            AppDimens.widthPercentage(0.04, context)
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 14, 
              sigmaY: 14
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimens.widthPercentage(0.04, context)
                )
              ),
              padding: EdgeInsets.symmetric(
                vertical: AppDimens.heightPercentage(0.03, context),
                horizontal: AppDimens.widthPercentage(0.06, context)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GradientSpinner(size: AppDimens.widthPercentage(0.18, context)),
                  SizedBox(height: AppDimens.heightPercentage(0.02, context)),
                  Text(
                    message ?? 'Cargando...',
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDimens.normalText(context),
                      letterSpacing: 0.2
                    )
                  ),
                  SizedBox(height: AppDimens.heightPercentage(0.006, context)),
                  Opacity(
                    opacity: 0.75,
                    child: Text(
                      subtitle ?? 'Esto puede tardar unos segundos…',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: AppDimens.normalText(context),
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
    final double thickness = widget.size * 0.12;

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
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.15)
            ]
          ),
          child: Center(
            child: Container(
              width: widget.size - thickness * 2.2,
              height: widget.size - thickness * 2.2,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.65),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: AppDimens.widthPercentage(0.02, context),
                    spreadRadius: AppDimens.widthPercentage(0.01, context)
                  )
                ]
              ),
              child: Icon(
                Icons.sync_rounded,
                size: AppDimens.normalIcon(context),
                color: AppColors.iconInfo
              )
            )
          )
        )
      )
    );
  }
}