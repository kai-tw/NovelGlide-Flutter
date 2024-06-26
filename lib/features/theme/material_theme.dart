import 'package:flutter/material.dart';

import 'theme_template.dart';

class MaterialTheme extends ThemeTemplate{
  static final MaterialTheme instance = _instance;
  static final MaterialTheme _instance = MaterialTheme._();

  factory MaterialTheme() => instance;
  MaterialTheme._();

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
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF415f91),
    brightness: Brightness.light,
  );

  /// The color scheme for dark theme
  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF415f91),
    brightness: Brightness.dark,
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