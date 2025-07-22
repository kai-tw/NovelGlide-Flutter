part of 'app_global_cubit.dart';

class AppGlobalState extends Equatable {
  const AppGlobalState({
    this.appearanceData = const AppearanceData(),
    this.locale,
  });

  final AppearanceData appearanceData;
  final Locale? locale;

  @override
  List<Object?> get props => <Object?>[
        appearanceData,
        locale,
      ];
}
