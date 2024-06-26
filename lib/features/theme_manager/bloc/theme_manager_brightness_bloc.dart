import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeManagerBrightnessCubit extends Cubit<ThemeManagerBrightnessState> {
  ThemeManagerBrightnessCubit({Brightness? brightness}) : super(ThemeManagerBrightnessState(brightness: brightness));

  void setBrightness(Brightness? brightnessType) {
    emit(ThemeManagerBrightnessState(brightness: brightnessType));
  }
}

class ThemeManagerBrightnessState extends Equatable {
  final Brightness? brightness;

  const ThemeManagerBrightnessState({
    this.brightness,
  });

  @override
  List<Object?> get props => [brightness];
}
