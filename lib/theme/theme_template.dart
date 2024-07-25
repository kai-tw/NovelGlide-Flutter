import 'package:flutter/material.dart';

abstract class ThemeTemplate {
  abstract final ThemeData lightTheme;
  abstract final ThemeData darkTheme;

  ThemeData getThemeByBrightness({Brightness? brightness}) {
    final Brightness platformBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return (brightness ?? platformBrightness) == Brightness.light ? lightTheme : darkTheme;
  }

  static ThemeData generateThemeByBrightness(ColorScheme colorScheme) {
    return ThemeData(
      appBarTheme: getAppBarTheme(colorScheme),
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      floatingActionButtonTheme: getFloatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme,
      snackBarTheme: getSnackBarTheme(colorScheme),
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

  static FloatingActionButtonThemeData getFloatingActionButtonTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(36.0))),
    );
  }

  static SnackBarThemeData getSnackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
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
