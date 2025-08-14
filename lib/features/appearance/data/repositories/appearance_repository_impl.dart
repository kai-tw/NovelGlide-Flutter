import '../../../preference/domain/entities/preference_keys.dart';
import '../../../preference/domain/repositories/preference_repository.dart';
import '../../domain/entities/app_default_theme.dart';
import '../../domain/entities/appearance_settings.dart';
import '../../domain/repositories/appearance_repository.dart';

class AppearanceRepositoryImpl extends AppearanceRepository {
  AppearanceRepositoryImpl(
    this._preferenceRepository,
  );

  final PreferenceRepository _preferenceRepository;

  @override
  Future<AppearanceSettings> getAppearanceSettings() async {
    // Load the theme mode preference.
    final int themeModeIndex =
        await _preferenceRepository.tryGetInt(PreferenceKeys.appThemeMode) ??
            AppThemeMode.system.index;

    // Return the settings.
    return AppearanceSettings(
      themeMode: AppThemeMode.values[themeModeIndex],
      theme: const AppDefaultTheme(),
    );
  }

  @override
  Future<void> saveAppearanceSettings(AppearanceSettings settings) {
    return _preferenceRepository.setInt(
        PreferenceKeys.appThemeMode, settings.themeMode.index);
  }
}
