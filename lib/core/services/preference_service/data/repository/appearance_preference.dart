part of '../../preference_service.dart';

class AppearancePreference
    extends PreferenceRepository<AppearancePreferenceData> {
  final String _themeModeKey = 'themeMode';

  @override
  Future<AppearancePreferenceData> load() async {
    return AppearancePreferenceData(
      themeMode: ThemeMode
          .values[await tryGetInt(_themeModeKey) ?? ThemeMode.system.index],
    );
  }

  @override
  Future<void> save(AppearancePreferenceData data) async {
    await Future.wait(<Future<void>>[
      setInt(_themeModeKey, data.themeMode.index),
    ]);

    // Notify listeners
    onChangedController.add(null);
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      remove(_themeModeKey),
    ]);

    // Notify listeners
    onChangedController.add(null);
  }
}
