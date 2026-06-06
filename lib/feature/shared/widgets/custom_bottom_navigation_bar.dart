import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:consultify/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String?>? routes;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.routes,
  });

  static const double barHeight = 68;
  static const double _fabGap = 12;

  /// Espacio vertical que ocupa la barra flotante del shell.
  static double reservedBottomSpace(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final outerBottomPadding = bottomInset > 0 ? 1.0 : 4.0;
    return barHeight + outerBottomPadding + _fabGap;
  }

  /// Padding inferior recomendado para listas dentro del shell.
  static double scrollBottomPadding(
    BuildContext context, {
    bool withFloatingActionButton = false,
  }) {
    const contentGap = 16.0;
    final fabSpace = withFloatingActionButton
        ? LabeledFloatingActionButton.reservedHeight
        : 0.0;

    return reservedBottomSpace(context) + fabSpace + contentGap;
  }

  static final _items = [
    _NavBarItem(
      icon: FontAwesomeIcons.houseChimney.data,
      label: 'Inicio',
    ),
    /* _NavBarItem(
      icon: FontAwesomeIcons.houseChimney.data,
      label: 'Nuevo',
    ),
    _NavBarItem(
      icon: FontAwesomeIcons.houseChimney.data,
      label: 'Nuevo',
    ), */
    _NavBarItem(
      icon: FontAwesomeIcons.user.data,
      label: 'Perfil',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomInset > 0 ? 6 : 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.22),
              blurRadius: 24,
              offset: const Offset(0, 10),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          height: barHeight,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: AppColors.secondary,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: List.generate(_items.length, (index) {
              return Expanded(
                child: _BottomNavItem(
                  item: _items[index],
                  isSelected: currentIndex == index,
                  onTap: () {
                    onTap(index);
                    if (routes != null &&
                        index < routes!.length &&
                        routes![index] != null &&
                        routes![index]!.isNotEmpty) {
                      context.go(routes![index]!);
                    }
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem {
  final IconData icon;
  final String label;

  const _NavBarItem({
    required this.icon,
    required this.label,
  });
}

class _BottomNavItem extends StatelessWidget {
  final _NavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.secondaryButton;
    final inactiveColor = AppColors.secondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        splashColor: activeColor.withValues(alpha: 0.15),
        highlightColor: activeColor.withValues(alpha: 0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.tertiaryBackground
                : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            border: isSelected
                ? Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                size: 20,
                color: isSelected ? activeColor : inactiveColor,
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  fontSize: 11,
                  height: 1.1,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
