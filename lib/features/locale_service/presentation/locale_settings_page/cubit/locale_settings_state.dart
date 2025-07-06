part of '../../../locale_services.dart';

class LocaleSettingsState extends Equatable {
  const LocaleSettingsState({
    this.selectedLocale,
  });

  final Locale? selectedLocale;

  @override
  List<Object?> get props => <Object?>[selectedLocale];
}
