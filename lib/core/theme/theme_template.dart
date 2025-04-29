import 'package:flutter/material.dart';

abstract class ThemeTemplate {
  /// Generates a [ThemeData] object based on the provided [ColorScheme]
  ThemeData getThemeByScheme(ColorScheme colorScheme) {
    return ThemeData(
      appBarTheme: getAppBarTheme(colorScheme),
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      floatingActionButtonTheme: getFabTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme,
      snackBarTheme: getSnackBarTheme(colorScheme),
      switchTheme: getSwitchTheme(colorScheme),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: inputDecorationTheme,
      ),
      sliderTheme: const SliderThemeData(
        year2023: false,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        year2023: false,
      ),
      useMaterial3: true,
    );
  }

  /// Defines the input decoration theme
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  /// Configures the AppBar theme based on the ColorScheme
  AppBarTheme getAppBarTheme(ColorScheme colorScheme) {
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

  /// Configures the [FloatingActionButton] theme based on the [ColorScheme]
  FloatingActionButtonThemeData getFabTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(36.0)),
      ),
    );
  }

  /// Configures the [SnackBar] theme based on the [ColorScheme]
  SnackBarThemeData getSnackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  /// Configures the [Switch] theme based on the [ColorScheme]
  SwitchThemeData getSwitchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return colorScheme.onSurface.withValues(alpha: 0.38);
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
