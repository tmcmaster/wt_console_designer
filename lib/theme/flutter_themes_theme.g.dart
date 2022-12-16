import 'package:flutter/material.dart';

import 'flutter_themes_colors.g.dart';
import 'flutter_themes_text_styles.g.dart';

class FlutterThemesTheme {
  static const TextTheme textTheme = TextTheme(
    headline1: FlutterThemesTextStyles.headline1,
    headline2: FlutterThemesTextStyles.headline2,
    headline3: FlutterThemesTextStyles.headline3,
    headline4: FlutterThemesTextStyles.headline4,
    headline5: FlutterThemesTextStyles.headline5,
    headline6: FlutterThemesTextStyles.headline6,
    subtitle1: FlutterThemesTextStyles.subtitle1,
    subtitle2: FlutterThemesTextStyles.subtitle2,
    bodyText1: FlutterThemesTextStyles.bodyText1,
    bodyText2: FlutterThemesTextStyles.bodyText2,
    button: FlutterThemesTextStyles.button,
    caption: FlutterThemesTextStyles.caption,
    overline: FlutterThemesTextStyles.overline,
  );

  static const ColorScheme light = ColorScheme.light(
      onPrimary: FlutterThemesColors.lightOnPrimary,
      primary: FlutterThemesColors.lightPrimary,
      primaryContainer: FlutterThemesColors.lightPrimaryContainer,
      secondary: FlutterThemesColors.lightSecondary,
      onSecondary: FlutterThemesColors.lightOnSecondary,
      onPrimaryContainer: FlutterThemesColors.lightOnPrimaryContainer,
      secondaryContainer: FlutterThemesColors.lightSecondaryContainer,
      onSecondaryContainer: FlutterThemesColors.lightOnSecondaryContainer,
      onTertiary: FlutterThemesColors.lightOnTertiary,
      tertiary: FlutterThemesColors.lightTertiary,
      tertiaryContainer: FlutterThemesColors.lightTertiaryContainer,
      onTertiaryContainer: FlutterThemesColors.lightOnTertiaryContainer,
      error: FlutterThemesColors.lightError,
      onError: FlutterThemesColors.lightOnError,
      errorContainer: FlutterThemesColors.lightErrorContainer,
      onErrorContainer: FlutterThemesColors.lightOnErrorContainer,
      background: FlutterThemesColors.lightBackground,
      onBackground: FlutterThemesColors.lightOnBackground,
      surface: FlutterThemesColors.lightSurface,
      onSurface: FlutterThemesColors.lightOnSurface,
      surfaceVariant: FlutterThemesColors.lightSurfaceVariant,
      onSurfaceVariant: FlutterThemesColors.lightOnSurfaceVariant,
      outline: FlutterThemesColors.lightOutline,
      inverseSurface: FlutterThemesColors.lightInverseSurface,
      onInverseSurface: FlutterThemesColors.lightOnInverseSurface,
      inversePrimary: FlutterThemesColors.lightInversePrimary,
      surfaceTint: FlutterThemesColors.lightSurfaceTint);

  static ThemeData themeDataLight = ThemeData(
    textTheme: textTheme,
    colorScheme: light,
  );

  static const ColorScheme dark = ColorScheme.dark(
      primary: FlutterThemesColors.darkPrimary,
      onPrimary: FlutterThemesColors.darkOnPrimary,
      primaryContainer: FlutterThemesColors.darkPrimaryContainer,
      onPrimaryContainer: FlutterThemesColors.darkOnPrimaryContainer,
      secondary: FlutterThemesColors.darkSecondary,
      onSecondary: FlutterThemesColors.darkOnSecondary,
      secondaryContainer: FlutterThemesColors.darkSecondaryContainer,
      onSecondaryContainer: FlutterThemesColors.darkOnSecondaryContainer,
      tertiary: FlutterThemesColors.darkTertiary,
      onTertiary: FlutterThemesColors.darkOnTertiary,
      tertiaryContainer: FlutterThemesColors.darkTertiaryContainer,
      onTertiaryContainer: FlutterThemesColors.darkOnTertiaryContainer,
      error: FlutterThemesColors.darkError,
      onError: FlutterThemesColors.darkOnError,
      errorContainer: FlutterThemesColors.darkErrorContainer,
      onErrorContainer: FlutterThemesColors.darkOnErrorContainer,
      background: FlutterThemesColors.darkBackground,
      onBackground: FlutterThemesColors.darkOnBackground,
      surface: FlutterThemesColors.darkSurface,
      onSurface: FlutterThemesColors.darkOnSurface,
      surfaceVariant: FlutterThemesColors.darkSurfaceVariant,
      outline: FlutterThemesColors.darkOutline,
      inverseSurface: FlutterThemesColors.darkInverseSurface,
      inversePrimary: FlutterThemesColors.darkInversePrimary,
      surfaceTint: FlutterThemesColors.darkSurfaceTint,
      onSurfaceVariant: FlutterThemesColors.darkOnSurfaceVariant,
      onInverseSurface: FlutterThemesColors.darkOnInverseSurface);

  static ThemeData themeDataDark = ThemeData(
    textTheme: textTheme,
    colorScheme: dark,
  );
}
