part of '../../../appearance_services.dart';

class AppearanceSettingsDarkModeCardCubit extends Cubit<AppearanceSettingsDarkModeCardState> {
  AppearanceSettingsDarkModeCardCubit()
      : super(AppearanceSettingsDarkModeCardState(
          isDarkMode: AppearanceServices.isDarkMode,
        ));

  void setDarkMode(bool? isDarkMode) {
    emit(AppearanceSettingsDarkModeCardState(
      isDarkMode: isDarkMode,
    ));
    AppearanceServices.setDarkMode(isDarkMode);
  }
}
