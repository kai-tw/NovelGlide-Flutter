import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/appearance_services/appearance_services.dart';
import '../../../features/locale_service/locale_services.dart';
import '../../services/preference_service/preference_service.dart';

part 'app_global_state.dart';

class AppGlobalCubit extends Cubit<AppGlobalState> {
  factory AppGlobalCubit() {
    final AppGlobalCubit cubit = AppGlobalCubit._();

    // Listen to appearance changes.
    cubit.onAppearanceChangedSubscription = PreferenceService
        .appearance.onChangedController.stream
        .listen((_) => cubit._refreshState());

    // Listen to locale changes.
    cubit.onLocaleChangedSubscription = PreferenceService
        .locale.onChangedController.stream
        .listen((_) => cubit._refreshState());
    return cubit;
  }

  AppGlobalCubit._()
      : super(AppGlobalState(
          themeMode: AppearanceServices.themeMode,
          theme: AppearanceServices.theme,
          locale: LocaleServices.userLocale,
        ));

  // Listen changes.
  late final StreamSubscription<void> onAppearanceChangedSubscription;
  late final StreamSubscription<void> onLocaleChangedSubscription;

  Future<void> _refreshState() async {
    emit(AppGlobalState(
      themeMode: AppearanceServices.themeMode,
      theme: AppearanceServices.theme,
      locale: LocaleServices.userLocale,
    ));
  }

  @override
  Future<void> close() {
    onAppearanceChangedSubscription.cancel();
    onLocaleChangedSubscription.cancel();
    return super.close();
  }
}
