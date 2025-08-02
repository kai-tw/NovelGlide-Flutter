import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferenceExtension on SharedPreferences {
  int? tryGetInt(String key) {
    try {
      return getInt(key);
    } catch (_) {
      return null;
    }
  }

  double? tryGetDouble(String key) {
    try {
      return getDouble(key);
    } catch (_) {
      return null;
    }
  }

  bool? tryGetBool(String key) {
    try {
      return getBool(key);
    } catch (_) {
      return null;
    }
  }

  String? tryGetString(String key) {
    try {
      return getString(key);
    } catch (_) {
      return null;
    }
  }
}
