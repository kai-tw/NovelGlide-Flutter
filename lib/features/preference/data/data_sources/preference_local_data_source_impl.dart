import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/preference_keys.dart';
import 'preference_local_data_source.dart';

class PreferenceLocalDataSourceImpl implements PreferenceLocalDataSource {
  PreferenceLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> setBool(PreferenceKeys key, bool value) {
    return _prefs.setBool(key.toString(), value);
  }

  @override
  Future<void> setDouble(PreferenceKeys key, double value) {
    return _prefs.setDouble(key.toString(), value);
  }

  @override
  Future<void> setInt(PreferenceKeys key, int value) {
    return _prefs.setInt(key.toString(), value);
  }

  @override
  Future<void> setString(PreferenceKeys key, String value) {
    return _prefs.setString(key.toString(), value);
  }

  @override
  Future<bool?> tryGetBool(PreferenceKeys key) async {
    try {
      return _prefs.getBool(key.toString());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<double?> tryGetDouble(PreferenceKeys key) async {
    try {
      return _prefs.getDouble(key.toString());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int?> tryGetInt(PreferenceKeys key) async {
    try {
      return _prefs.getInt(key.toString());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> tryGetString(PreferenceKeys key) async {
    try {
      return _prefs.getString(key.toString());
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> remove(PreferenceKeys key) {
    return _prefs.remove(key.toString());
  }
}
