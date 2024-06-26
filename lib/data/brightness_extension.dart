import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  static Brightness? getFromString(String? str) {
    try {
      return Brightness.values.firstWhere((e) => e.toString() == str);
    } catch (e) {
      return null;
    }
  }
}