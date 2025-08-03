import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/appearance/domain/entities/app_theme.dart';
import '../../features/appearance/domain/entities/appearance_settings.dart';
import '../../features/appearance/domain/use_cases/get_appearance_settings_use_case.dart';
import '../../features/appearance/domain/use_cases/save_appearance_settings_use_case.dart';
import '../../features/locale/domain/entities/app_locale.dart';
import '../../features/locale/domain/entities/locale_settings.dart';
import '../../features/locale/domain/use_cases/get_locale_settings_use_case.dart';
import '../../features/locale/domain/use_cases/save_locale_settings_use_case.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  factory AppCubit(
    GetAppearanceSettingsUseCase getAppearanceSettingsUseCase,
    SaveAppearanceSettingsUseCase saveAppearanceSettingsUseCase,
    GetLocaleSettingsUseCase getLocaleSettingsUseCase,
    SaveLocaleSettingsUseCase saveLocaleSettingsUseCase,
  ) {
    const AppearanceSettings defaultSettings = AppearanceSettings();
    return AppCubit._(
      AppState(
        themeMode: defaultSettings.themeMode,
        theme: defaultSettings.theme,
      ),
      getAppearanceSettingsUseCase,
      saveAppearanceSettingsUseCase,
      getLocaleSettingsUseCase,
      saveLocaleSettingsUseCase,
    );
  }

  AppCubit._(
    super.initialState,
    this._getAppearanceSettingsUseCase,
    this._saveAppearanceSettingsUseCase,
    this._getLocaleSettingsUseCase,
    this._saveLocaleSettingsUseCase,
  );

  final GetAppearanceSettingsUseCase _getAppearanceSettingsUseCase;
  final SaveAppearanceSettingsUseCase _saveAppearanceSettingsUseCase;
  final GetLocaleSettingsUseCase _getLocaleSettingsUseCase;
  final SaveLocaleSettingsUseCase _saveLocaleSettingsUseCase;

  Future<void> init() async {
    final AppearanceSettings settings = await _getAppearanceSettingsUseCase();
    final LocaleSettings localeSettings = await _getLocaleSettingsUseCase();
    emit(AppState(
      themeMode: settings.themeMode,
      theme: settings.theme,
      userLocale: localeSettings.userLocale,
    ));
  }

  Future<void> changeThemeMode(AppThemeMode themeMode) async {
    // Emit the new state.
    emit(state.copyWith(themeMode: themeMode));

    // Save the theme mode.
    _saveAppearanceSettingsUseCase(AppearanceSettings(
      themeMode: themeMode,
      theme: state.theme,
    ));
  }

  Future<void> changeLocale(AppLocale? locale) async {
    // Emit the new state.
    emit(state.copyWithUserLocale(locale));

    // Save the locale.
    _saveLocaleSettingsUseCase(LocaleSettings(
      userLocale: locale,
    ));
  }
}
