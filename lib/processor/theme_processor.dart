import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../data/theme_data_record.dart';
import '../data/theme_id.dart';
import '../theme/theme_template.dart';

class ThemeProcessor {
  /// Get the theme template by id.
  static ThemeTemplate getThemeTemplateById(ThemeId id) {
    return ThemeIdExtension.getThemeTemplateById(id);
  }

  /// Get the theme name by id.
  static String? getThemeNameById(BuildContext context, ThemeId id) {
    return ThemeIdExtension.getThemeNameById(context, id);
  }

  /// Get the theme data by id.
  static ThemeData getThemeDataById(ThemeId id) {
    final Brightness? brightness = ThemeDataRecord.fromSettings().brightness;
    return ThemeIdExtension.getThemeTemplateById(id).getThemeByBrightness(brightness: brightness);
  }

  /// Get the theme data by record.
  static ThemeData getThemeDataByRecord(ThemeDataRecord record) {
    return getThemeDataById(record.themeId);
  }

  /// Get the theme from the settings.
  static ThemeData getThemeDataFromSettings() {
    return getThemeDataById(ThemeDataRecord.fromSettings().themeId);
  }

  /// Only switch theme.
  static void switchTheme(
    BuildContext context, {
    ThemeId? id,
  }) {
    final ThemeDataRecord themeDataRecord = ThemeDataRecord.fromSettings();
    themeDataRecord.themeId = id ?? themeDataRecord.themeId;
    themeDataRecord.saveToSettings();

    _switchTheme(context, themeDataRecord);
  }

  /// Only switch brightness.
  static void switchBrightness(
    BuildContext context, {
    Brightness? brightness,
  }) {
    final ThemeDataRecord themeDataRecord = ThemeDataRecord.fromSettings();
    themeDataRecord.brightness = brightness;
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
