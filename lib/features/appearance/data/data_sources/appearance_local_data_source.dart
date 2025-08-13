import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/shared_preference_extension.dart';
import '../../domain/entities/appearance_settings.dart';

abstract class AppearanceLocalDataSource {
  Future<AppThemeMode> getThemeMode();

  Future<void> saveThemeMode(AppThemeMode themeMode);
}

class AppearanceLocalDataSourceImpl implements AppearanceLocalDataSource {
  AppearanceLocalDataSourceImpl(this.prefs);

  final SharedPreferences prefs;
  final String _themeModeKey = 'themeMode';

  @override
  Future<AppThemeMode> getThemeMode() async {
    return AppThemeMode
        .values[prefs.tryGetInt(_themeModeKey) ?? AppThemeMode.system.index];
  }

  @override
  Future<void> saveThemeMode(AppThemeMode themeMode) {
    return prefs.setInt(_themeModeKey, themeMode.index);
  }
}
