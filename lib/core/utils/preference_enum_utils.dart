import 'package:shared_preferences/shared_preferences.dart';

class PreferenceEnumUtils {
  PreferenceEnumUtils._();

  static int? getEnumIndex(SharedPreferences? prefs, String key) {
    try {
      return prefs?.getInt(key);
    } catch (_) {
      return null;
    }
  }
}
