// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  /* //************************* Colores principales ************************** */
  static const secondary = Colors.black;
  static const primary = Colors.white;

  //************************* Colores para el texto ************************** */
  static const textSecondary = Colors.white;
  static const textPrimary = Colors.black;
  static const textInfo = Color.fromARGB(255, 0, 26, 255);
  static const textInfoDark = Color.fromARGB(255, 3, 28, 166);

  //************************* Colores para el background ********************* */
  static const primaryBackground = Color.fromRGBO(229, 229, 229, 1);
  static const secondaryBackground = Colors.white;
  static const tertiaryBackground = Color.fromRGBO(245, 243, 243, 1);
  static const scanQrBackground = Colors.black;

  //************************* Colores para el botón ************************** */
  static const primaryButton = Colors.black;
  static const secondaryButton = Color.fromARGB(255, 18, 42, 255);
  static const secondaryButtonDark = Color.fromARGB(255, 3, 28, 166);

  //************************* Colores para alertas, errores, etc. ************** */
  static const errorBackground = Colors.red;
  static const warningBackground = Colors.orange;
  static const successBackground = Colors.green;
  static const disabledBackground = Colors.grey;
  static const infoBackground = Color.fromARGB(255, 0, 26, 255);
  static const infoBackgroundDark = Color.fromARGB(255, 3, 28, 166);

  //************************* Colores para los iconos ************************** */
  static const iconPrimary = Colors.black;
  static const iconSecondary = Colors.white;
  static const iconTertiary = Color.fromRGBO(229, 229, 229, 1);
  static const iconDisabled = Colors.grey;
  static const iconError = Colors.red;
  static const iconWarning = Colors.orange;
  static const iconSuccess = Colors.green;
  static const iconInfo = Color.fromARGB(255, 0, 26, 255);
  static const iconInfoDark = Color.fromARGB(255, 3, 28, 166); */

  // ************************* Colores principales ************************** //
  /// Azul Marino del logo para elementos oscuros primarios
  static const secondary = Color(0xFF1E4264);
  /// Blanco puro para elementos de contraste limpios
  static const primary = Colors.white;

  // ************************* Colores para el texto ************************** //
  static const textSecondary = Colors.white;
  static const textPrimary = Color(0xFF1E4264); // Azul Marino del logo para textos principales
  static const textInfo = Color(0xFF5CC0C6); // Turquesa claro del logo para textos informativos
  static const textInfoDark = Color(0xFF1E4264); // Azul Marino oscuro del logo

  // ************************* Colores para el background ********************* //
  /// Gris azulado muy suave basado en el logo para el fondo principal (reemplaza al gris 229,229,229)
  static const primaryBackground = Color(0xFFF0F4F8);
  static const secondaryBackground = Colors.white;
  /// Tono menta/turquesa ultra claro para destacar contenedores de la agenda
  static const tertiaryBackground = Color(0xFFE6F6F7);
  static const scanQrBackground = Colors.black;

  // ************************* Colores para el botón ************************** //
  static const primaryButton = Color.fromARGB(255, 21, 79, 133); // Azul Marino principal del logo
  static const secondaryButton = Color(0xFF5CC0C6); // Turquesa brillante del logo
  static const secondaryButtonDark = Color(0xFF132A40); // Azul Marino profundo para el estado presionado

  // ************************* Colores para alertas, errores, etc. ************** //
  static const errorBackground = Colors.red;
  static const warningBackground = Colors.orange;
  static const successBackground = Colors.green;
  static const disabledBackground = Colors.grey;
  static const infoBackground = Color(0xFF5CC0C6); // Turquesa del logo
  static const infoBackgroundDark = Color(0xFF1E4264); // Azul Marino del logo

  // ************************* Colores para los iconos ************************** //
  static const iconPrimary = Color(0xFF1E4264); // Iconos principales en Azul Marino
  static const iconSecondary = Colors.white;
  static const iconTertiary = Color(0xFFF0F4F8);
  static const iconDisabled = Colors.grey;
  static const iconError = Colors.red;
  static const iconWarning = Colors.orange;
  static const iconSuccess = Colors.green;
  static const iconInfo = Color(0xFF5CC0C6); // Turquesa
  static const iconInfoDark = Color(0xFF1E4264); // Azul Marino



  
}

enum ScreenSize { little, mid, big }

enum ScreenOrientation { landscape, portrait }

class AppDimens {
  static double getHeightWithoutContext(double perc) =>
  (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height) *
  perc;

  static double getWidthWithoutContext(double perc) =>
  (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width) *
  perc;

  static double safeHeightPercentage(double percentage, BuildContext context) {
    final media = _getMediaFromContext(context);
    return (media.size.height - media.padding.top - media.padding.bottom) *
    percentage;
  }

  static double safeWidthPercentage(double percentage, BuildContext context) {
    final media = _getMediaFromContext(context);
    return (media.size.width - media.padding.left - media.padding.right) *
        percentage;
  }

  static double cardHeaderText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.054
            : minorSize > 580
                ? 0.063
                : 0.07);
  }

  static double giantText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.045
            : minorSize > 580
                ? 0.049
                : 0.065);
  }

  static double titleText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.039
            : minorSize > 580
                ? 0.042
                : 0.05);
  }

  static double subtitleText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.031
            : minorSize > 580
                ? 0.033
                : 0.045);
  }

  static double normalText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.027
            : minorSize > 580
                ? 0.030
                : 0.036);
  }

  static double littleText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.027
            : minorSize > 580
                ? 0.029
                : 0.0345);
  }

  static double tinyText(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.023
            : minorSize > 580
                ? 0.025
                : 0.029);
  }

  static double normalSplashRadius(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize > 780
        ? 10
        : minorSize > 580
            ? 15
            : 20;
  }

  static double giantIcon(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.59
            : minorSize > 580
                ? 0.065
                : 0.09);
  }

  static double bigIcon(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.047
            : minorSize > 580
                ? 0.052
                : 0.07);
  }

  static double normalIcon(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.039
            : minorSize > 580
                ? 0.042
                : 0.05);
  }

  static double littleIcon(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.032
            : minorSize > 580
                ? 0.034
                : 0.046);
  }

  static double tinyIcon(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? 0.029
            : minorSize > 580
                ? 0.031
                : 0.04);
  }

  static double getSizeByOrientation(double onLandscapePercentage,
      double onPortraitPercentage, bool takeMajor, BuildContext context) {
    final media = _getMediaFromContext(context);
    final isLandScape = _isLandScape(media);
    late double size;
    if (isLandScape) {
      size = onLandscapePercentage;
      if (takeMajor) {
        return size * media.size.width;
      } else {
        return size * media.size.height;
      }
    } else {
      size = onPortraitPercentage;
      if (takeMajor) {
        return size * media.size.height;
      } else {
        return size * media.size.width;
      }
    }
  }

  static double widthPercentage(double percentage, BuildContext context) =>
      _getMediaFromContext(context).size.width * percentage;

  static double heightPercentage(double percentage, BuildContext context) =>
      _getMediaFromContext(context).size.height * percentage;

  static MediaQueryData _getMediaFromContext(BuildContext context) =>
      MediaQuery.of(context);

  static ScreenOrientation getOrientation(BuildContext context) {
    final media = _getMediaFromContext(context);
    return _isLandScape(media)
        ? ScreenOrientation.landscape
        : ScreenOrientation.portrait;
  }

  static bool _isLandScape(MediaQueryData media) =>
      media.orientation == Orientation.landscape;

  static ScreenSize getScreenDimension(BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return (minorSize > 750
        ? ScreenSize.big
        : minorSize > 550
            ? ScreenSize.mid
            : ScreenSize.little);
  }

  static double getSizeByScreenDimension(
      double bigPercentage,
      double midPercentage,
      double littlePercentage,
      bool isMajorScreenValue,
      BuildContext context) {
    final screenSize = getScreenDimension(context);
    return (screenSize == ScreenSize.big
        ? getSizeByOrientation(
            bigPercentage, bigPercentage, isMajorScreenValue, context)
        : screenSize == ScreenSize.mid
            ? getSizeByOrientation(
                midPercentage, midPercentage, isMajorScreenValue, context)
            : getSizeByOrientation(littlePercentage, littlePercentage,
                isMajorScreenValue, context));
  }

  static double smallBorderRadius(double percentage, BuildContext context) {
    final minorSize = getSizeByOrientation(1, 1, false, context);
    return minorSize *
        (minorSize > 780
            ? percentage
            : minorSize > 580
                ? percentage
                : percentage);
  }
}
