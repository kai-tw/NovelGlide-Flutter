part of '../../../locale_services.dart';

class LocaleSettingsCubit extends Cubit<LocaleSettingsState> {
  factory LocaleSettingsCubit() {
    final LocaleSettingsCubit instance = LocaleSettingsCubit._();
    instance._init();
    return instance;
  }

  LocaleSettingsCubit._() : super(const LocaleSettingsState());

  Future<void> _init() async {
    emit(LocaleSettingsState(
      selectedLocale: await LocaleServices.getUserLocale(),
    ));
  }

  Future<void> selectLocale(BuildContext context, Locale? locale) async {
    await LocaleServices.setUserLocale(locale);
    AppLocaleCubit.setLocale(locale);
    emit(LocaleSettingsState(selectedLocale: locale));
  }
}
