import 'package:flutter/material.dart';

import 'theme_template.dart';

class DefaultTheme extends ThemeTemplate {
  static final lightTheme =
      ThemeTemplate.generateThemeByBrightness(_lightColorScheme);
  static final darkTheme =
      ThemeTemplate.generateThemeByBrightness(_darkColorScheme);

  /// The color scheme for light theme
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff71411e),
    surfaceTint: Color(0xff85522d),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xff9b653e),
    onPrimaryContainer: Color(0xffffffff),
    secondary: Color(0xff745947),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffffddc9),
    onSecondaryContainer: Color(0xff5d4333),
    tertiary: Color(0xff4f5017),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xff747538),
    onTertiaryContainer: Color(0xffffffff),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff410002),
    surface: Color(0xfffff8f5),
    onSurface: Color(0xff201a17),
    onSurfaceVariant: Color(0xff52443c),
    outline: Color(0xff84746b),
    outlineVariant: Color(0xffd6c3b8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff352f2c),
    inversePrimary: Color(0xfffcb88b),
    primaryFixed: Color(0xffffdcc6),
    onPrimaryFixed: Color(0xff311300),
    primaryFixedDim: Color(0xfffcb88b),
    onPrimaryFixedVariant: Color(0xff693b18),
    secondaryFixed: Color(0xffffdcc6),
    onSecondaryFixed: Color(0xff2a1709),
    secondaryFixedDim: Color(0xffe3bfaa),
    onSecondaryFixedVariant: Color(0xff5a4131),
    tertiaryFixed: Color(0xffe6e79e),
    onTertiaryFixed: Color(0xff1c1d00),
    tertiaryFixedDim: Color(0xffcaca84),
    onTertiaryFixedVariant: Color(0xff484911),
    surfaceDim: Color(0xffe3d8d2),
    surfaceBright: Color(0xfffff8f5),
    surfaceContainerLowest: Color(0xffffffff),
    surfaceContainerLow: Color(0xfffdf1eb),
    surfaceContainer: Color(0xfff7ece6),
    surfaceContainerHigh: Color(0xfff2e6e0),
    surfaceContainerHighest: Color(0xffece0db),
  );

  /// The color scheme for dark theme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xfffcb88b),
    surfaceTint: Color(0xfffcb88b),
    onPrimary: Color(0xff4e2504),
    primaryContainer: Color(0xff7f4d29),
    onPrimaryContainer: Color(0xffffffff),
    secondary: Color(0xffe3bfaa),
    onSecondary: Color(0xff422b1c),
    secondaryContainer: Color(0xff523a2a),
    onSecondaryContainer: Color(0xfff2cdb7),
    tertiary: Color(0xffcaca84),
    onTertiary: Color(0xff323200),
    tertiaryContainer: Color(0xff5a5b21),
    onTertiaryContainer: Color(0xfffffeff),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    surface: Color(0xff17120f),
    onSurface: Color(0xffece0db),
    onSurfaceVariant: Color(0xffd6c3b8),
    outline: Color(0xff9f8d83),
    outlineVariant: Color(0xff52443c),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffece0db),
    inversePrimary: Color(0xff85522d),
    primaryFixed: Color(0xffffdcc6),
    onPrimaryFixed: Color(0xff311300),
    primaryFixedDim: Color(0xfffcb88b),
    onPrimaryFixedVariant: Color(0xff693b18),
    secondaryFixed: Color(0xffffdcc6),
    onSecondaryFixed: Color(0xff2a1709),
    secondaryFixedDim: Color(0xffe3bfaa),
    onSecondaryFixedVariant: Color(0xff5a4131),
    tertiaryFixed: Color(0xffe6e79e),
    onTertiaryFixed: Color(0xff1c1d00),
    tertiaryFixedDim: Color(0xffcaca84),
    onTertiaryFixedVariant: Color(0xff484911),
    surfaceDim: Color(0xff17120f),
    surfaceBright: Color(0xff3e3834),
    surfaceContainerLowest: Color(0xff120d0a),
    surfaceContainerLow: Color(0xff201a17),
    surfaceContainer: Color(0xff241e1b),
    surfaceContainerHigh: Color(0xff2f2925),
    surfaceContainerHighest: Color(0xff3a3330),
  );
}
