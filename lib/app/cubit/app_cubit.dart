import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/appearance/domain/entities/app_theme.dart';
import '../../features/locale_system/domain/entities/app_locale.dart';
import '../../features/preference/domain/entities/appearance_preference_data.dart';
import '../../features/preference/domain/entities/locale_preference_data.dart';
import '../../features/preference/domain/use_cases/preference_get_use_cases.dart';
import '../../features/preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../../features/preference/domain/use_cases/preference_save_use_case.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  factory AppCubit(
    AppearanceGetPreferenceUseCase appearanceGetPreferenceUseCase,
    AppearanceSavePreferenceUseCase appearanceSavePreferenceUseCase,
    AppearanceObservePreferenceChangeUseCase
        appearanceObservePreferenceChangeUseCase,
    LocaleGetPreferenceUseCase localeGetPreferenceUseCase,
    LocaleSavePreferenceUseCase localeSavePreferenceUseCase,
    LocaleObservePreferenceChangeUseCase localeObservePreferenceChangeUseCase,
  ) {
    const AppearancePreferenceData defaultSettings = AppearancePreferenceData();
    return AppCubit._(
      AppState(
        themeMode: defaultSettings.themeMode,
        theme: defaultSettings.theme,
      ),
      appearanceGetPreferenceUseCase,
      appearanceSavePreferenceUseCase,
      appearanceObservePreferenceChangeUseCase,
      localeGetPreferenceUseCase,
      localeSavePreferenceUseCase,
      localeObservePreferenceChangeUseCase,
    );
  }

  AppCubit._(
    super.initialState,
    this._appearanceGetPreferenceUseCase,
    this._appearanceSavePreferenceUseCase,
    this._appearanceObservePreferenceChangeUseCase,
    this._localeGetPreferenceUseCase,
    this._localeSavePreferenceUseCase,
    this._localeObservePreferenceChangeUseCase,
  );

  final AppearanceGetPreferenceUseCase _appearanceGetPreferenceUseCase;
  final AppearanceSavePreferenceUseCase _appearanceSavePreferenceUseCase;
  final AppearanceObservePreferenceChangeUseCase
      _appearanceObservePreferenceChangeUseCase;
  final LocaleGetPreferenceUseCase _localeGetPreferenceUseCase;
  final LocaleSavePreferenceUseCase _localeSavePreferenceUseCase;
  final LocaleObservePreferenceChangeUseCase
      _localeObservePreferenceChangeUseCase;

  /// Stream subscriptions
  late final StreamSubscription<AppearancePreferenceData>
      _appearancePreferenceChangeSubscription;
  late final StreamSubscription<LocalePreferenceData>
      _localePreferenceChangeSubscription;

  Future<void> init() async {
    final AppearancePreferenceData settings =
        await _appearanceGetPreferenceUseCase();
    final LocalePreferenceData localeSettings =
        await _localeGetPreferenceUseCase();
    emit(AppState(
      themeMode: settings.themeMode,
      theme: settings.theme,
      userLocale: localeSettings.userLocale,
    ));

    // Register streams
    _appearancePreferenceChangeSubscription =
        _appearanceObservePreferenceChangeUseCase().listen(_onAppearanceChange);
    _localePreferenceChangeSubscription =
        _localeObservePreferenceChangeUseCase().listen(_onLocaleChange);
  }

  Future<void> changeThemeMode(AppThemeMode themeMode) async {
    // Save the theme mode.
    _appearanceSavePreferenceUseCase(AppearancePreferenceData(
      themeMode: themeMode,
      theme: state.theme,
    ));
  }

  Future<void> changeLocale(AppLocale? locale) async {
    // Save the locale.
    _localeSavePreferenceUseCase(LocalePreferenceData(
      userLocale: locale,
    ));
  }

  void _onAppearanceChange(AppearancePreferenceData data) {
    emit(state.copyWith(themeMode: data.themeMode));
  }

  void _onLocaleChange(LocalePreferenceData data) {
    emit(state.copyWithUserLocale(data.userLocale));
  }

  @override
  Future<void> close() async {
    await _appearancePreferenceChangeSubscription.cancel();
    await _localePreferenceChangeSubscription.cancel();
    return super.close();
  }
}
