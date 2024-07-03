import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/theme_data_record.dart';

class ThemeManagerBrightnessCubit extends Cubit<ThemeManagerBrightnessState> {
  bool isEnabled = false;

  ThemeManagerBrightnessCubit() : super(const ThemeManagerBrightnessState());

  void refresh() async {
    final Brightness? brightness = ThemeDataRecord.fromSettings().brightness;
    emit(ThemeManagerBrightnessState(brightness: brightness));
  }

  void setBrightness(Brightness? brightness) async {
    emit(ThemeManagerBrightnessState(brightness: brightness));
  }
}

class ThemeManagerBrightnessState extends Equatable {
  final Brightness? brightness;

  const ThemeManagerBrightnessState({this.brightness});

  @override
  List<Object?> get props => [brightness];
}
