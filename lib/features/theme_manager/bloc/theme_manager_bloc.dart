import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/theme_data_record.dart';

class ThemeManagerCubit extends Cubit<ThemeManagerState> {
  final ScrollController scrollController = ScrollController();

  ThemeManagerCubit() : super(const ThemeManagerState());

  Future<void> init() async {
    final ThemeDataRecord record = await ThemeDataRecord.fromSettings();
    emit(ThemeManagerState(brightness: record.brightness));
  }

  Future<void> setBrightness(Brightness? brightness) async {
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

  const ThemeManagerState({
    this.brightness,
  });
}
