// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
  //************************* Colores principales ************************** */
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
  static const iconInfoDark = Color.fromARGB(255, 3, 28, 166);



  /*static const backgroundSnackBarBlack = Colors.black;
  static const primaryDark = Color.fromARGB(255, 0, 60, 145);
  static const primaryLight = Color.fromARGB(255, 211, 222, 238);
  static const secondaryLight = Color.fromARGB(255, 86, 187, 187);
  static const diamond = Color.fromARGB(255, 171, 218, 226);
  static const borderBackground = Color.fromARGB(255, 255, 0, 0);
  static const tertiary = Color.fromARGB(255, 23, 166, 166);
  static const textFieldBackground = Color.fromARGB(255, 242, 242, 242);
  static const boxBackground = Color.fromARGB(255, 230, 230, 230);
  static const shadow = Color.fromARGB(255, 220, 220, 220);
  static const lightShadow = Color.fromARGB(255, 235, 235, 235);
  static const darkShadow = Color.fromARGB(255, 150, 150, 150);
  static const background = Color.fromARGB(255, 255, 255, 255);
  static const optional = Color.fromARGB(255, 0, 0, 0);
  static const yellow = Color.fromARGB(255, 218, 130, 15);
  static const administrator = Color.fromARGB(253, 12, 2, 61);
  static const transparent = Colors.transparent;
  static const black = Colors.black;*/
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
