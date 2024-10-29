import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BrightnessUtils {
  /// Converts a string representation of brightness to a Brightness enum value.
  /// Returns null if the string does not match any Brightness value.
  static Brightness? getFromString(String? str) {
    return Brightness.values.firstWhereOrNull((e) => e.toString() == str);
  }
}
