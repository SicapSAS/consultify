import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';

class AppBarLogo extends StatelessWidget {
  final String? imagePath;
  final double? width;
  final double? height;

  const AppBarLogo({
    super.key,
    this.imagePath,
    this.width,
    this.height,
  });

  static const String _defaultLogoPath = 'assets/logo/white_label.png';

  @override
  Widget build(BuildContext context) {
    final path = imagePath ?? _defaultLogoPath;
    final logoWidth = width ?? AppDimens.widthPercentage(0.3, context);

    return Image.asset(
      path,
      width: logoWidth,
      //height: height ?? kToolbarHeight - 16,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
    );
  }
}
