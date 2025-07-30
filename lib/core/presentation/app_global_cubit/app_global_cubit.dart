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
    _instance ??= AppGlobalCubit._();
    _instance?._refreshState();

    // Listen to appearance changes.
    _instance?.onAppearanceChangedSubscription = PreferenceService
        .appearancePreference.onChangedController.stream
        .listen((_) => _instance?._refreshState());

    return _instance!;
  }

  AppGlobalCubit._()
      : super(AppGlobalState(
          appearanceData: PreferenceService.appearancePreference.data,
          locale: LocaleServices.userLocale,
        ));

  static AppGlobalCubit? _instance;

  static void refreshState() => _instance?._refreshState();

  // Listen to appearance changes.
  late final StreamSubscription<void> onAppearanceChangedSubscription;

  Future<void> _refreshState() async {
    emit(AppGlobalState(
      appearanceData: await PreferenceService.appearancePreference.load(),
      locale: LocaleServices.userLocale,
    ));
  }

  @override
  Future<void> close() {
    _instance = null;
    onAppearanceChangedSubscription.cancel();
    return super.close();
  }
}
