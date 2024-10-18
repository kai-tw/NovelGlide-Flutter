import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/theme_data_record.dart';

class ThemeManagerCubit extends Cubit<ThemeManagerState> {
  final ScrollController scrollController = ScrollController();

  factory ThemeManagerCubit() =>
      ThemeManagerCubit._internal(const ThemeManagerState()).._initialize();

  ThemeManagerCubit._internal(super.initialState);

  Future<void> _initialize() async {
    final ThemeDataRecord record = await ThemeDataRecord.fromSettings();
    emit(ThemeManagerState(brightness: record.brightness));
  }

  /// Set the brightness of the theme.
  set brightness(Brightness? brightness) =>
      emit(ThemeManagerState(brightness: brightness));

  @override
  Future<void> close() async {
    super.close();
    scrollController.dispose();
  }
}

class ThemeManagerState extends Equatable {
  final Brightness? brightness;

  @override
  List<Object?> get props => [brightness];

  const ThemeManagerState({this.brightness});
}
