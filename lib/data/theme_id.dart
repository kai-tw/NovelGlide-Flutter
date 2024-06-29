import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/default_theme.dart';
import '../theme/material_theme.dart';
import '../theme/theme_template.dart';
import '../theme/yellow_theme.dart';

enum ThemeId {
  defaultTheme,
  materialTheme,
  yellowTheme,
}

extension ThemeIdExtension on ThemeId {
  /// Get the theme template by id.
  static ThemeTemplate getThemeTemplateById(ThemeId id) {
    final Map<ThemeId, ThemeTemplate> themeDataMap = {
      ThemeId.defaultTheme: DefaultTheme(),
      ThemeId.materialTheme: MaterialTheme(),
      ThemeId.yellowTheme: YellowTheme(),
    };
    return themeDataMap[id] ?? DefaultTheme();
  }

  /// Get the theme name by id.
  static String? getThemeNameById(BuildContext context, ThemeId id) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<ThemeId, String> themeNameMap = {
      ThemeId.defaultTheme: appLocalizations.themeListNameDefault,
      ThemeId.materialTheme: appLocalizations.themeListNameMaterial,
      ThemeId.yellowTheme: appLocalizations.themeListNameYellow,
    };
    return themeNameMap[id];
  }

  static ThemeId? getFromString(String? str) {
    try {
      return ThemeId.values.firstWhere((e) => e.toString() == str);
    } catch (e) {
      return null;
    }
  }
}