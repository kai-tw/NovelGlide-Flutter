part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.themeMode,
    required this.theme,
    this.locale,
  });

  final AppThemeMode themeMode;
  final AppTheme theme;
  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        theme,
        locale,
      ];

  AppState copyWith({
    AppThemeMode? themeMode,
    AppTheme? theme,
    Locale? locale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
    );
  }
}
