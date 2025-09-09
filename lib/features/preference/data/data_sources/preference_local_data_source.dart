import '../../domain/entities/preference_keys.dart';

abstract class PreferenceLocalDataSource {
  Future<int?> tryGetInt(PreferenceKeys key);

  Future<double?> tryGetDouble(PreferenceKeys key);

  Future<bool?> tryGetBool(PreferenceKeys key);

  Future<String?> tryGetString(PreferenceKeys key);

  Future<void> setInt(PreferenceKeys key, int value);

  Future<void> setDouble(PreferenceKeys key, double value);

  Future<void> setBool(PreferenceKeys key, bool value);

  Future<void> setString(PreferenceKeys key, String value);

  Future<void> remove(PreferenceKeys key);
}
