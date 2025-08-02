import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/appearance/domain/entities/app_theme.dart';
import '../../features/appearance/domain/entities/appearance_settings.dart';
import '../../features/appearance/domain/use_cases/get_appearance_settings_use_case.dart';
import '../../features/appearance/domain/use_cases/save_appearance_settings_use_case.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  factory AppCubit(
    GetAppearanceSettingsUseCase getAppearanceSettingsUseCase,
    SaveAppearanceSettingsUseCase saveAppearanceSettingsUseCase,
  ) {
    const AppearanceSettings defaultSettings = AppearanceSettings();
    return AppCubit._(
      AppState(
        themeMode: defaultSettings.themeMode,
        theme: defaultSettings.theme,
      ),
      getAppearanceSettingsUseCase,
      saveAppearanceSettingsUseCase,
    );
  }

  AppCubit._(
    super.initialState,
    this._getAppearanceSettingsUseCase,
    this._saveAppearanceSettingsUseCase,
  );

  final GetAppearanceSettingsUseCase _getAppearanceSettingsUseCase;
  final SaveAppearanceSettingsUseCase _saveAppearanceSettingsUseCase;

  Future<void> init() async {
    final AppearanceSettings settings = await _getAppearanceSettingsUseCase();
    emit(AppState(
      themeMode: settings.themeMode,
      theme: settings.theme,
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
}
