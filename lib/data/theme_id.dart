import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../features/theme/default_theme.dart';
import '../features/theme/material_theme.dart';
import '../features/theme/theme_template.dart';

enum ThemeId {
  defaultTheme,
  materialTheme,
}

extension ThemeIdExtension on ThemeId {
  /// Get the theme template by id.
  static ThemeTemplate getThemeTemplateById(ThemeId id) {
    final Map<ThemeId, ThemeTemplate> themeDataMap = {
      ThemeId.defaultTheme: DefaultTheme(),
      ThemeId.materialTheme: MaterialTheme(),
    };
    return themeDataMap[id] ?? DefaultTheme();
  }

  /// Get the theme name by id.
  static String? getThemeNameById(BuildContext context, ThemeId id) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<ThemeId, String> themeNameMap = {
      ThemeId.defaultTheme: appLocalizations.themeListNameDefault,
      ThemeId.materialTheme: "Material",
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