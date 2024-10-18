import 'package:flutter/material.dart';

import '../theme/default_theme.dart';
import '../theme/material_theme.dart';
import '../theme/yellow_theme.dart';

/// Enum representing different theme identifiers.
enum ThemeId {
  defaultTheme,
  materialTheme,
  yellowTheme;

  /// Get the theme template by id based on the brightness.
  ThemeData getThemeDataByBrightness({Brightness? brightness}) {
    final bool isLight =
        (brightness ?? WidgetsBinding.instance.platformDispatcher.platformBrightness) == Brightness.light;

    switch (this) {
      case ThemeId.materialTheme:
        return isLight ? MaterialTheme.lightTheme : MaterialTheme.darkTheme;
      case ThemeId.yellowTheme:
        return isLight ? YellowTheme.lightTheme : YellowTheme.darkTheme;
      default:
        return isLight ? DefaultTheme.lightTheme : DefaultTheme.darkTheme;
    }
  }

  /// Retrieve a [ThemeId] from a string representation.
  static ThemeId? getFromString(String? str) {
    try {
      return ThemeId.values.firstWhere((e) => e.toString() == str);
    } catch (e) {
      return null;
    }
  }
}
