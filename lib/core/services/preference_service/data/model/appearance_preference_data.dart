part of '../../preference_service.dart';

class AppearancePreferenceData extends Equatable {
  const AppearancePreferenceData({
    this.themeMode = ThemeMode.system,
    this.theme = const DefaultTheme(),
  });

  final ThemeMode themeMode;
  final ThemeTemplate theme;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        theme,
      ];
}
