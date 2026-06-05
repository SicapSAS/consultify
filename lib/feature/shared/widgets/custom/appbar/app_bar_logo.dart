import 'package:flutter/material.dart';

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

  static const String _defaultLogoPath = 'assets/logo/consultify_transparente2.png';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final path = imagePath ?? _defaultLogoPath;
    final logoWidth = width ?? size.width * 0.3;

    return Image.asset(
      path,
      width: logoWidth,
      //height: height ?? kToolbarHeight - 16,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
    );
  }
}
