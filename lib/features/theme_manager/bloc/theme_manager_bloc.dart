import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_model/theme_data_record.dart';

class ThemeManagerCubit extends Cubit<ThemeManagerState> {
  final ScrollController scrollController = ScrollController();

  factory ThemeManagerCubit() {
    final cubit = ThemeManagerCubit._internal(const ThemeManagerState());
    cubit._initialize();
    return cubit;
  }

  ThemeManagerCubit._internal(super.initialState);

  Future<void> _initialize() async {
    final record = await ThemeDataRecord.fromSettings();
    emit(ThemeManagerState(brightness: record.brightness));
  }

  /// Set the brightness of the theme.
  void setBrightness(Brightness? brightness) {
    emit(ThemeManagerState(brightness: brightness));
  }

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
