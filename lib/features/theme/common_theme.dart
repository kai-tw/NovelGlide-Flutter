import 'package:flutter/material.dart';

class CommonTheme {
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
          return colorScheme.secondary;
        }
        return colorScheme.onPrimary;
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
