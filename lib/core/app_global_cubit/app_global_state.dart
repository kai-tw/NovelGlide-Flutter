part of 'app_global_cubit.dart';

class AppGlobalState extends Equatable {
  const AppGlobalState({
    this.isDarkMode,
    this.locale,
  });

  final bool? isDarkMode;
  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[
        isDarkMode,
        locale,
      ];
}
