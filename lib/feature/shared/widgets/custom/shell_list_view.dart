import 'package:consultify/feature/feature.dart';
import 'package:flutter/material.dart';

/// ListView con padding y scroll estándar para listas dentro del shell.
class ShellListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double separatorHeight;
  final bool withFloatingActionButton;
  final EdgeInsetsGeometry? padding;

  const ShellListView.separated({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorHeight = 12,
    this.withFloatingActionButton = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: padding ??
          EdgeInsets.fromLTRB(
            16,
            12,
            16,
            CustomBottomNavigationBar.scrollBottomPadding(
              context,
              withFloatingActionButton: withFloatingActionButton,
            ),
          ),
      itemCount: itemCount,
      separatorBuilder: (context, _) => SizedBox(height: separatorHeight),
      itemBuilder: itemBuilder,
    );
  }
}
