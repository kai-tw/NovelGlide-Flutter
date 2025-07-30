part of '../../preference_service.dart';

abstract class PreferenceRepository<T> {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<T> load();
  Future<void> save(T data);
  Future<void> reset();

  final StreamController<void> onChangedController =
      StreamController<void>.broadcast();

  Future<int?> tryGetInt(String key) async {
    try {
      return (await _prefs).getInt(key);
    } catch (_) {
      return null;
    }
  }

  Future<double?> tryGetDouble(String key) async {
    try {
      return (await _prefs).getDouble(key);
    } catch (_) {
      return null;
    }
  }

  Future<bool?> tryGetBool(String key) async {
    try {
      return (await _prefs).getBool(key);
    } catch (_) {
      return null;
    }
  }

  Future<String?> tryGetString(String key) async {
    try {
      return (await _prefs).getString(key);
    } catch (_) {
      return null;
    }
  }

  Future<void> setInt(String key, int value) async =>
      (await _prefs).setInt(key, value);

  Future<void> setDouble(String key, double value) async =>
      (await _prefs).setDouble(key, value);

  Future<void> setBool(String key, bool value) async =>
      (await _prefs).setBool(key, value);

  Future<void> setString(String key, String value) async =>
      (await _prefs).setString(key, value);

  Future<void> remove(String key) async => (await _prefs).remove(key);
}
