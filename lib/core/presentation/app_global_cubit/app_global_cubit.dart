import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/appearance_services/appearance_services.dart';
import '../../../features/locale_service/locale_services.dart';

part 'app_global_state.dart';

class AppGlobalCubit extends Cubit<AppGlobalState> {
  factory AppGlobalCubit() {
    _instance ??= AppGlobalCubit._();
    refreshState();
    return _instance!;
  }

  AppGlobalCubit._()
      : super(AppGlobalState(
          appearanceData: AppearanceServices.preference.data,
          locale: LocaleServices.userLocale,
        ));

  static AppGlobalCubit? _instance;

  static void refreshState() => _instance?._refreshState();

  Future<void> _refreshState() async {
    emit(AppGlobalState(
      appearanceData: await AppearanceServices.preference.load(),
      locale: LocaleServices.userLocale,
    ));
  }

  @override
  Future<void> close() {
    _instance = null;
    return super.close();
  }
}
