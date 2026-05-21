import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';

import 'app_bar_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? logoPath;
  final String? backRoute;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.logoPath,
    this.backRoute,
    this.onBackPressed,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
  }) : assert(
          backRoute == null || onBackPressed == null,
          'No se puede proporcionar tanto backRoute como onBackPressed',
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.secondaryBackground,
      title: title != null && title!.isNotEmpty ? Text(
        title!,
        style: TextStyle(
          fontSize: AppDimens.giantText(context) * 0.85,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary
        )
      ) : AppBarLogo(imagePath: logoPath),
      centerTitle: centerTitle,
      leading: _buildLeading(context),
      actions: actions,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (backRoute == null && onBackPressed == null) {
      return null;
    }

    return IconButton(
      onPressed: () {
        if (onBackPressed != null) {
          onBackPressed!();
        } else if (backRoute != null) {
          context.go(backRoute!);
        }
      },
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: AppColors.secondary,
        size: AppDimens.bigIcon(context)
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
