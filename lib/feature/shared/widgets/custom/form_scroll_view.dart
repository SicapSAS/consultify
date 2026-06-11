import 'package:flutter/material.dart';

/// Contenedor scrollable con padding estándar para formularios y vistas de creación.
class FormScrollView extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool reverse;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const FormScrollView({
    super.key,
    required this.child,
    this.padding,
    this.physics,
    this.reverse = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  static const EdgeInsets defaultPadding = EdgeInsets.fromLTRB(16, 12, 16, 16);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding ?? defaultPadding,
      physics: physics,
      reverse: reverse,
      keyboardDismissBehavior: keyboardDismissBehavior,
      child: child,
    );
  }
}
