part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    required this.themeMode,
    required this.theme,
    this.userLocale,
  });

  final AppThemeMode themeMode;
  final AppTheme theme;
  final AppLocale? userLocale;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        theme,
        userLocale,
      ];

  AppState copyWith({
    AppThemeMode? themeMode,
    AppTheme? theme,
    AppLocale? userLocale,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      theme: theme ?? this.theme,
      userLocale: userLocale ?? this.userLocale,
    );
  }

  AppState copyWithUserLocale(AppLocale? userLocale) {
    return AppState(
      themeMode: themeMode,
      theme: theme,
      userLocale: userLocale,
    );
  }
}
