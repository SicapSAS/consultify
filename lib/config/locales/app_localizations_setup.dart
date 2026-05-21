import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocaleConfig {
  /// Lista de idiomas soportados
  static const supportedLocales = [
    Locale('es'),
    Locale('en'),
  ];

  /// Delegados necesarios para traducir widgets nativos (Material, Cupertino, etc.)
  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}