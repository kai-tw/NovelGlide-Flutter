part of 'app_global_cubit.dart';

class AppGlobalState extends Equatable {
  const AppGlobalState({
    this.themeMode,
    this.locale,
  });

  final ThemeMode? themeMode;
  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[
        themeMode,
        locale,
      ];
}
