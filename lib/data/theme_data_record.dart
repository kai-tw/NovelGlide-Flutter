import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';
import 'brightness_extension.dart';
import '../enum/theme_id.dart';

/// Represents a record of theme data, including theme ID and brightness.
class ThemeDataRecord {
  ThemeId themeId;
  Brightness? brightness;

  ThemeDataRecord({
    this.themeId = ThemeId.defaultTheme,
    this.brightness,
  });

  /// Creates a [ThemeDataRecord] from a JSON map.
  factory ThemeDataRecord.fromJson(Map<String, dynamic> json) {
    return ThemeDataRecord(
      themeId: ThemeId.getFromString(json["themeId"]) ?? ThemeId.defaultTheme,
      brightness: BrightnessExtension.getFromString(json["brightness"]),
    );
  }

  /// Loads the theme data from shared preferences.
  static Future<ThemeDataRecord> fromSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ThemeDataRecord(
      themeId: ThemeId.getFromString(
              prefs.getString(PreferenceKeys.theme.themeId)) ??
          ThemeId.defaultTheme,
      brightness: BrightnessExtension.getFromString(
          prefs.getString(PreferenceKeys.theme.brightness)),
    );
  }

  /// Converts the theme data to a JSON string.
  String toJson() {
    return jsonEncode({
      "themeId": themeId.toString(),
      "brightness": brightness?.toString(),
    });
  }

  /// Saves the current theme data to shared preferences.
  Future<void> saveToSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKeys.theme.themeId, themeId.toString());

    if (brightness != null) {
      prefs.setString(PreferenceKeys.theme.brightness, brightness!.toString());
    } else {
      prefs.remove(PreferenceKeys.theme.brightness);
    }
  }
}
