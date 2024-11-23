import 'package:flutter/material.dart';

abstract class ThemeTemplate {
  /// Generates a [ThemeData] object based on the provided [ColorScheme]
  static ThemeData getThemeByScheme(ColorScheme colorScheme) {
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
      useMaterial3: true,
    );
  }

  /// Defines the input decoration theme
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 16),
        contentPadding: const EdgeInsets.all(24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  /// Configures the AppBar theme based on the ColorScheme
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

  /// Configures the [FloatingActionButton] theme based on the [ColorScheme]
  static FloatingActionButtonThemeData getFabTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(36.0)),
      ),
    );
  }

  /// Configures the [SnackBar] theme based on the [ColorScheme]
  static SnackBarThemeData getSnackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    );
  }

  /// Configures the [Switch] theme based on the [ColorScheme]
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
