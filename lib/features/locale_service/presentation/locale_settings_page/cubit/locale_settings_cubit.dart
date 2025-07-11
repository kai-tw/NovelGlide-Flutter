part of '../../../locale_services.dart';

class LocaleSettingsCubit extends Cubit<LocaleSettingsState> {
  LocaleSettingsCubit()
      : super(LocaleSettingsState(
          selectedLocale: LocaleServices.userLocale,
        ));

  void selectLocale(BuildContext context, Locale? locale) {
    emit(LocaleSettingsState(selectedLocale: locale));
    LocaleServices.userLocale = locale;
  }
}
