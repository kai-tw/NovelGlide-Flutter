import 'package:flutter/material.dart';

import 'common_theme.dart';

class LightTheme {
  static final ThemeData themeData = ThemeData(
    appBarTheme: _appBarTheme,
    brightness: Brightness.light,
    colorScheme: _colorScheme,
    inputDecorationTheme: CommonTheme.inputDecorationTheme,
    splashColor: Colors.transparent,
    switchTheme: _switchTheme,
    useMaterial3: true,
  );

  static final AppBarTheme _appBarTheme = CommonTheme.getAppBarTheme(_colorScheme);
  static final SwitchThemeData _switchTheme = CommonTheme.getSwitchTheme(_colorScheme);

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF282828),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFB9E9FF),
    onPrimaryContainer: Color(0xFF001F24),
    secondary: Color(0xFF4A6267),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCDE7EC),
    onSecondaryContainer: Color(0xFF051F23),
    tertiary: Color(0xFF525E7D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFDAE2FF),
    onTertiaryContainer: Color(0xFF0E1B37),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF171717),
    onSurfaceVariant: Color(0xFF3F484A),
    outline: Color(0xFF6F797A),
    outlineVariant: Color(0xFFBFC8CA),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF2B3133),
    // inverseOnSurface: Color(0xFFECF2F3),
    inversePrimary: Color(0xFF82D3E0),
    surfaceDim: Color(0xFFD5DBDC),
    surfaceBright: Color(0xFFF5FAFB),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFEFF5F6),
    surfaceContainer: Color(0xFFE9EFF0),
    surfaceContainerHigh: Color(0xFFE3E9EA),
    surfaceContainerHighest: Color(0xFFDEE3E5),
  );
}
