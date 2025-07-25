part of '../../appearance_services.dart';

class AppearancePreference extends PreferenceRepository<AppearanceData> {
  final String _themeModeKey = PreferenceKeys.themeMode;

  late AppearanceData data;

  @override
  Future<AppearanceData> load() async {
    data = AppearanceData(
      themeMode: ThemeMode
          .values[await tryGetInt(_themeModeKey) ?? ThemeMode.system.index],
    );
    return data;
  }

  @override
  Future<void> save(AppearanceData data) async {
    await Future.wait(<Future<void>>[
      setInt(_themeModeKey, data.themeMode.index),
    ]);
  }

  @override
  Future<void> reset() async {
    await Future.wait(<Future<void>>[
      remove(_themeModeKey),
    ]);
  }
}
