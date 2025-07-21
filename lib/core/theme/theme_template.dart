import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeTemplate {
  /// Generates a [ThemeData] object based on the provided [ColorScheme]
  ThemeData getThemeByScheme(ColorScheme colorScheme) {
    // Configures the [InputDecoration] theme based on the [ColorScheme]
    final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      labelStyle: const TextStyle(fontSize: 16),
      contentPadding: const EdgeInsets.all(24.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return ThemeData(
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) {
          return const Icon(Icons.arrow_back_ios_new_rounded);
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surface,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: switch (colorScheme.brightness) {
            Brightness.dark => Brightness.light,
            Brightness.light => Brightness.dark,
          },
          systemStatusBarContrastEnforced: false,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarIconBrightness: switch (colorScheme.brightness) {
            Brightness.dark => Brightness.light,
            Brightness.light => Brightness.dark,
          },
        ),
      ),
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: inputDecorationTheme,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(36.0)),
        ),
      ),
      inputDecorationTheme: inputDecorationTheme,
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        year2023: false,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      switchTheme: SwitchThemeData(
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
      ),
      sliderTheme: const SliderThemeData(
        year2023: false,
      ),
      useMaterial3: true,
    );
  }
}
