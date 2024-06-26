import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/theme_data_record.dart';
import '../data/theme_id.dart';
import '../features/theme/default_theme.dart';
import '../features/theme/theme_template.dart';

class ThemeProcessor {
  /// Get the theme template by id.
  static ThemeTemplate getThemeTemplateById(ThemeId id) {
    return ThemeIdExtension.getThemeTemplateById(id);
  }

  /// Get the theme name by id.
  static String? getThemeNameById(BuildContext context, ThemeId id) {
    return ThemeIdExtension.getThemeNameById(context, id);
  }

  /// Get the theme data by record.
  static ThemeData getThemeDataByRecord(ThemeDataRecord record) {
    final ThemeTemplate themeTemplate = getThemeTemplateById(record.themeId);
    return themeTemplate.getThemeByBrightness(brightness: record.brightness);
  }

  /// Only switch theme.
  static void switchTheme(
    BuildContext context, {
    ThemeId? id,
  }) {
    ThemeDataRecord themeDataRecord = ThemeDataRecord.fromSettings();
    themeDataRecord = themeDataRecord.copyWith(
      themeId: id ?? themeDataRecord.themeId,
    );
    themeDataRecord.saveToSettings();

    _switchTheme(context, themeDataRecord);
  }

  /// Only switch brightness.
  static void switchBrightness(
    BuildContext context, {
    Brightness? brightness,
  }) {
    ThemeDataRecord themeDataRecord = ThemeDataRecord.fromSettings();
    themeDataRecord = themeDataRecord.copyWith(
      brightness: brightness,
    );
    themeDataRecord.saveToSettings();

    _switchTheme(context, themeDataRecord);
  }

  /// If the brightness of the platform is changed and the brightness of the record is null,
  /// then switch brightness.
  static void onBrightnessChanged(BuildContext context) {
    ThemeDataRecord themeDataRecord = ThemeDataRecord.fromSettings();

    if (themeDataRecord.brightness == null) {
      _switchTheme(context, themeDataRecord);
    }
  }

  /// Internal use only. Switch theme!
  static void _switchTheme(BuildContext context, ThemeDataRecord record) {
    final ThemeData themeData = getThemeDataByRecord(record);
    ThemeSwitcher.of(context).changeTheme(theme: themeData);
  }
}
