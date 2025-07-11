part of '../../../locale_services.dart';

class LocaleSettingsCubit extends Cubit<LocaleSettingsState> {
  LocaleSettingsCubit()
      : super(LocaleSettingsState(
          selectedLocale: LocaleServices.userLocale,
        ));

  Future<void> selectLocale(BuildContext context, Locale? locale) async {
    emit(LocaleSettingsState(selectedLocale: locale));
    await LocaleServices.setUserLocale(locale);
  }
}
