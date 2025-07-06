import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/locale_service/locale_services.dart';

part 'app_locale_state.dart';

class AppLocaleCubit extends Cubit<AppLocaleState> {
  factory AppLocaleCubit() {
    _instance ??= AppLocaleCubit._();
    return _instance!;
  }

  AppLocaleCubit._() : super(AppLocaleState(locale: LocaleServices.userLocale));

  static AppLocaleCubit? _instance;

  static void setLocale(Locale? locale) => _instance?._setLocale(locale);

  void _setLocale(Locale? locale) {
    emit(AppLocaleState(locale: locale));
  }
}
