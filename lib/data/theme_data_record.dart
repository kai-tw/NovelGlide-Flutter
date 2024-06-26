import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'brightness_extension.dart';
import 'theme_id.dart';

class ThemeDataRecord extends Equatable {
  final ThemeId themeId;
  final Brightness? brightness;

  @override
  List<Object?> get props => [themeId, brightness];

  const ThemeDataRecord({
    this.themeId = ThemeId.defaultTheme,
    this.brightness,
  });

  factory ThemeDataRecord.fromJson(Map<String, dynamic> json) {
    return ThemeDataRecord(
      themeId: ThemeIdExtension.getFromString(json["themeId"]) ?? ThemeId.defaultTheme,
      brightness: BrightnessExtension.getFromString(json["brightness"]),
    );
  }

  factory ThemeDataRecord.fromSettings() {
    final Box settingsBox = Hive.box(name: "settings");
    String themeRecord = settingsBox.get("theme", defaultValue: "{}");
    settingsBox.close();
    return ThemeDataRecord.fromJson(jsonDecode(themeRecord));
  }

  String toJson() {
    return jsonEncode({
      "themeId": themeId.toString(),
      "brightness": brightness?.toString(),
    });
  }

  ThemeDataRecord copyWith({
    ThemeId? themeId,
    Brightness? brightness,
  }) {
    return ThemeDataRecord(
      themeId: themeId ?? this.themeId,
      brightness: brightness,
    );
  }

  void saveToSettings() {
    final Box settingsBox = Hive.box(name: "settings");
    settingsBox.put("theme", toJson());
    print("save: ${toJson()}");
    settingsBox.close();
  }
}
