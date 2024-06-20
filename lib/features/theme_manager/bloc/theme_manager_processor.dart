import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../theme/default_theme.dart';
import '../../theme/theme_template.dart';

class ThemeManagerProcessor {
  static final Map<ThemeId, ThemeTemplate> themeDataMap = {
    ThemeId.defaultTheme: DefaultTheme(),
  };

  static String? getThemeNameById(BuildContext context, ThemeId type) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Map<ThemeId, String> themeNameMap = {
      ThemeId.defaultTheme: appLocalizations.themeListNameDefault,
    };
    return themeNameMap[type];
  }
}

enum ThemeId {
  defaultTheme,
}
