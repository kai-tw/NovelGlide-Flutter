import 'package:flutter/material.dart';

import 'theme_template.dart';

class DefaultTheme extends ThemeTemplate{
  static final DefaultTheme instance = _instance;
  static final DefaultTheme _instance = DefaultTheme._();

  factory DefaultTheme() => instance;
  DefaultTheme._();

  @override
  final ThemeData lightTheme = ThemeData(
    appBarTheme: getAppBarTheme(_lightColorScheme),
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    inputDecorationTheme: inputDecorationTheme,
    splashColor: Colors.transparent,
    switchTheme: getSwitchTheme(_lightColorScheme),
    useMaterial3: true,
  );

  @override
  final ThemeData darkTheme = ThemeData(
    appBarTheme: getAppBarTheme(_darkColorScheme),
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    inputDecorationTheme: inputDecorationTheme,
    splashColor: Colors.transparent,
    switchTheme: getSwitchTheme(_darkColorScheme),
    useMaterial3: true,
  );

  /// The color scheme for light theme
  static const ColorScheme _lightColorScheme = ColorScheme(
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

  /// The color scheme for dark theme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFBDBDBD),
    onPrimary: Color(0xFF3F3F3F),
    primaryContainer: Color(0xFF313131),
    onPrimaryContainer: Color(0xFFB4B4B4),
    secondary: Color(0xFFB1CBD0),
    onSecondary: Color(0xFF1C3438),
    secondaryContainer: Color(0xFF3F5B60),
    onSecondaryContainer: Color(0xFFCDE7EC),
    tertiary: Color(0xFFBAC6EA),
    onTertiary: Color(0xFF24304D),
    tertiaryContainer: Color(0xFF3B4664),
    onTertiaryContainer: Color(0xFFDAE2FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF171717),
    onSurface: Color(0xFFB7B7B7),
    onSurfaceVariant: Color(0xFFBFC8CA),
    outline: Color(0xFF899294),
    outlineVariant: Color(0xFF3F484A),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFDEE3E5),
    // inverseOnSurface: Color(0xFF2B3133),
    inversePrimary: Color(0xFF006874),
    surfaceDim: Color(0xFF0E1415),
    surfaceBright: Color(0xFF343A3B),
    surfaceContainerLowest: Color(0xFF090F10),
    surfaceContainerLow: Color(0xFF171D1E),
    surfaceContainer: Color(0xFF1B2122),
    surfaceContainerHigh: Color(0xFF252B2C),
    surfaceContainerHighest: Color(0xFF303637),
  );

  /// Common themes
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: const TextStyle(fontSize: 16),
    contentPadding: const EdgeInsets.all(24.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static AppBarTheme getAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surface,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 18,
      ),
    );
  }

  static SwitchThemeData getSwitchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withOpacity(0.38);
        }
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.primary;
      }),
      trackColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.onPrimary;
      }),
      splashRadius: 0.0,
    );
  }
}