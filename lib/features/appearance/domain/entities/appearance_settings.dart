import 'package:equatable/equatable.dart';

import 'app_default_theme.dart';
import 'app_theme.dart';

enum AppThemeMode { system, light, dark }

class AppearanceSettings extends Equatable {
  const AppearanceSettings({
    this.themeMode = AppThemeMode.system,
    this.theme = const AppDefaultTheme(),
  });

  final AppThemeMode themeMode;
  final AppTheme theme;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        theme,
      ];
}
