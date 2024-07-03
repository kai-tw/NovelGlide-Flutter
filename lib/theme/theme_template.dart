import 'package:flutter/material.dart';

import '../binding_center/binding_center.dart';

abstract class ThemeTemplate {
  abstract final ThemeData lightTheme;
  abstract final ThemeData darkTheme;

  ThemeData getThemeByBrightness({Brightness? brightness}) {
    final Brightness platformBrightness = ThemeBinding.instance.platformDispatcher.platformBrightness;
    return (brightness ?? platformBrightness) == Brightness.light ? lightTheme : darkTheme;
  }

  static ThemeData generateThemeByBrightness(ColorScheme colorScheme) {
    return ThemeData(
      appBarTheme: getAppBarTheme(colorScheme),
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      floatingActionButtonTheme: floatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme,
      splashColor: Colors.transparent,
      switchTheme: getSwitchTheme(colorScheme),
      useMaterial3: true,
    );
  }

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

  static FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const CircleBorder(),
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
