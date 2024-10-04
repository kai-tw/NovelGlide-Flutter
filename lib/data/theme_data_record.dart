import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_keys.dart';
import 'brightness_extension.dart';
import 'theme_id.dart';

class ThemeDataRecord {
  ThemeId themeId;
  Brightness? brightness;

  ThemeDataRecord({
    this.themeId = ThemeId.defaultTheme,
    this.brightness,
  });

  factory ThemeDataRecord.fromJson(Map<String, dynamic> json) {
    return ThemeDataRecord(
      themeId: ThemeId.getFromString(json["themeId"]) ?? ThemeId.defaultTheme,
      brightness: BrightnessExtension.getFromString(json["brightness"]),
    );
  }

  static Future<ThemeDataRecord> fromSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return ThemeDataRecord(
      themeId: ThemeId.getFromString(prefs.getString(PreferenceKeys.theme.themeId)) ?? ThemeId.defaultTheme,
      brightness: BrightnessExtension.getFromString(prefs.getString(PreferenceKeys.theme.brightness)),
    );
  }

  String toJson() {
    return jsonEncode({
      "themeId": themeId.toString(),
      "brightness": brightness?.toString(),
    });
  }

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
