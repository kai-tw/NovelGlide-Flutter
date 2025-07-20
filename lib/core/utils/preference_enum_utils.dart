import 'package:shared_preferences/shared_preferences.dart';

class PreferenceEnumUtils {
  PreferenceEnumUtils._();

  static int getEnumIndex(
    SharedPreferences? prefs,
    String key, {
    int defaultValue = 0,
  }) {
    try {
      return prefs?.getInt(key) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }
}
