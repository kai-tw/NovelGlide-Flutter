import '../../domain/entities/app_default_theme.dart';
import '../../domain/entities/appearance_settings.dart';
import '../../domain/repositories/appearance_repository.dart';
import '../data_sources/appearance_local_data_source.dart';

class AppearanceRepositoryImpl extends AppearanceRepository {
  AppearanceRepositoryImpl({
    required this.localDataSource,
  });

  final AppearanceLocalDataSource localDataSource;

  @override
  Future<AppearanceSettings> getAppearanceSettings() async {
    final AppThemeMode themeMode = await localDataSource.getThemeMode();
    return AppearanceSettings(
      themeMode: themeMode,
      theme: const AppDefaultTheme(),
    );
  }

  @override
  Future<void> saveAppearanceSettings(AppearanceSettings settings) {
    return localDataSource.saveThemeMode(settings.themeMode);
  }
}
