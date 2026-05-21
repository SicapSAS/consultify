import 'package:flutter/material.dart';
import 'package:consultify/config/config.dart';
import 'package:consultify/feature/feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Lista de atajos del home (Bitácora, Marcaciones, Reportes, etc.).
List<ShortcutItem> homeShortcuts (BuildContext context, WidgetRef ref) => [


  ShortcutItem(
    icon: FontAwesomeIcons.circle.data,
    label: 'Empresa 1',
    onTap: () => {},
    iconColor: AppColors.secondary,
  ),
  ShortcutItem(
    icon: FontAwesomeIcons.circle.data,
    label: 'Empresa 2',
    onTap: () => {},
    iconColor: AppColors.secondary,
  ),
];
