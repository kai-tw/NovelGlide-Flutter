import 'package:equatable/equatable.dart';

import '../../../appearance/domain/entities/app_default_theme.dart';
import '../../../appearance/domain/entities/app_theme.dart';

enum AppThemeMode { system, light, dark }

class AppearancePreferenceData extends Equatable {
  const AppearancePreferenceData({
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
