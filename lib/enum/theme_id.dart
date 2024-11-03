import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/default_theme.dart';
import '../theme/material_theme.dart';
import '../theme/wooden_theme.dart';
import '../theme/yellow_theme.dart';

/// Enum representing different theme identifiers.
enum ThemeId {
  defaultTheme,
  woodenTheme,
  materialTheme,
  yellowTheme;

  /// Get the theme template by id based on the brightness.
  ThemeData getThemeDataByBrightness([Brightness? brightness]) {
    final currentBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isLight = (brightness ?? currentBrightness) == Brightness.light;

    switch (this) {
      case ThemeId.defaultTheme:
        return isLight ? DefaultTheme.lightTheme : DefaultTheme.darkTheme;
      case ThemeId.woodenTheme:
        return isLight ? WoodenTheme.lightTheme : WoodenTheme.darkTheme;
      case ThemeId.materialTheme:
        return isLight ? MaterialTheme.lightTheme : MaterialTheme.darkTheme;
      case ThemeId.yellowTheme:
        return isLight ? YellowTheme.lightTheme : YellowTheme.darkTheme;
    }
  }

  static String? getThemeNameById(BuildContext context, ThemeId id) {
    final appLocalizations = AppLocalizations.of(context)!;
    switch (id) {
      case ThemeId.defaultTheme:
        return appLocalizations.themeListNameDefault;
      case ThemeId.woodenTheme:
        return appLocalizations.themeListNameWooden;
      case ThemeId.materialTheme:
        return appLocalizations.themeListNameMaterial;
      case ThemeId.yellowTheme:
        return appLocalizations.themeListNameYellow;
    }
  }

  /// Retrieve a [ThemeId] from a string representation.
  static ThemeId getFromString(
    String? str, {
    ThemeId defaultValue = ThemeId.defaultTheme,
  }) {
    return ThemeId.values.firstWhereOrNull((e) => e.toString() == str) ??
        defaultValue;
  }
}
