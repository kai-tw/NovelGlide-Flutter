import 'dart:async';

import '../../../appearance/domain/entities/app_default_theme.dart';
import '../../domain/entities/appearance_preference_data.dart';
import '../../domain/entities/preference_keys.dart';
import '../../domain/repositories/preference_repository.dart';
import '../data_sources/preference_local_data_source.dart';

class AppearancePreferenceRepositoryImpl
    extends AppearancePreferenceRepository {
  AppearancePreferenceRepositoryImpl(
    this._preferenceRepository,
  );

  final PreferenceLocalDataSource _preferenceRepository;

  /// Stream controller
  final StreamController<AppearancePreferenceData> _streamController =
      StreamController<AppearancePreferenceData>.broadcast();

  @override
  Future<AppearancePreferenceData> getPreference() async {
    // Load the theme mode preference.
    final int themeModeIndex =
        await _preferenceRepository.tryGetInt(PreferenceKeys.appThemeMode) ??
            AppThemeMode.system.index;

    // Return the settings.
    return AppearancePreferenceData(
      themeMode: AppThemeMode.values[themeModeIndex],
      theme: const AppDefaultTheme(),
    );
  }

  @override
  Future<void> savePreference(AppearancePreferenceData settings) async {
    await _preferenceRepository.setInt(
        PreferenceKeys.appThemeMode, settings.themeMode.index);
    _streamController.add(settings);
  }

  @override
  Stream<AppearancePreferenceData> get onChangeStream =>
      _streamController.stream;

  @override
  Future<void> resetPreference() async {}
}
