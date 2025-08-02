import 'package:novel_glide/features/appearance/data/data_sources/appearance_local_data_source.dart';
import 'package:novel_glide/features/appearance/domain/entities/app_default_theme.dart';
import 'package:novel_glide/features/appearance/domain/entities/appearance_settings.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';

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
