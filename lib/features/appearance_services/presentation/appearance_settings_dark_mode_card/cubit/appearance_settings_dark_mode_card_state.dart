part of '../../../appearance_services.dart';

class AppearanceSettingsDarkModeCardState extends Equatable {
  const AppearanceSettingsDarkModeCardState({
    this.isDarkMode,
  });

  final bool? isDarkMode;

  @override
  List<Object?> get props => <Object?>[isDarkMode];
}
