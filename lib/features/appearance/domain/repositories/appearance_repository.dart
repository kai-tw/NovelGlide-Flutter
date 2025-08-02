import '../entities/appearance_settings.dart';

abstract class AppearanceRepository {
  Future<AppearanceSettings> getAppearanceSettings();
  Future<void> saveAppearanceSettings(AppearanceSettings settings);
}
