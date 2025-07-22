part of '../../appearance_services.dart';

class AppearanceData extends Equatable {
  const AppearanceData({
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
