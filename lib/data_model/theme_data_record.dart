import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum/theme_id.dart';
import '../utils/brightness_utils.dart';
import 'preference_keys.dart';

/// Represents a record of theme data, including theme ID and brightness.
class ThemeDataRecord {
  ThemeId themeId;
  Brightness? brightness;

  static Future<ThemeData> get currentTheme async {
    final record = await ThemeDataRecord.fromSettings();
    return record.themeId.getThemeDataByBrightness(record.brightness);
  }

  ThemeDataRecord({
    this.themeId = ThemeId.defaultTheme,
    this.brightness,
  });

  /// Loads the theme data from shared preferences.
  static Future<ThemeDataRecord> fromSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final themeId = prefs.getString(PreferenceKeys.theme.themeId);
    final brightness = prefs.getString(PreferenceKeys.theme.brightness);
    return ThemeDataRecord(
      themeId: ThemeId.getFromString(themeId),
      brightness: BrightnessUtils.getFromString(brightness),
    );
  }

  static Future<void> saveId(ThemeId themeId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.theme.themeId, themeId.toString());
  }

  static Future<void> saveBrightness(Brightness? brightness) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.theme.brightness, brightness.toString());
  }
}
