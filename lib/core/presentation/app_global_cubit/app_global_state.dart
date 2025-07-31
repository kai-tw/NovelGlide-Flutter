part of 'app_global_cubit.dart';

class AppGlobalState extends Equatable {
  const AppGlobalState({
    required this.themeMode,
    required this.theme,
    this.locale,
  });

  final ThemeMode themeMode;
  final ThemeTemplate theme;
  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        theme,
        locale,
      ];
}
