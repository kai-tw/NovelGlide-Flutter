import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReaderSettingsCubit extends Cubit<ReaderSettingsState> {
  ReaderSettingsCubit() : super(const ReaderSettingsState());

  void loadSettings() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double fontSize = readerSetting.get('font_size') ?? 16.0;
    readerSetting.close();
    emit(ReaderSettingsState(fontSize: fontSize));
  }

  void setFontSize(double value) {
    emit(state.copyWith(fontSize: max(state.minFontSize, min(value, state.maxFontSize))));
  }

  void saveFontSize(double value) {
    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.put('font_size', value);
    readerSettings.close();
    emit(state.copyWith(fontSize: max(state.minFontSize, min(value, state.maxFontSize))));
  }
}

class ReaderSettingsState extends Equatable {
  final double fontSize;
  final double minFontSize = 12;
  final double maxFontSize = 32;

  const ReaderSettingsState({
    this.fontSize = 16,
  });

  ReaderSettingsState copyWith({
    double? fontSize,
  }) {
    return ReaderSettingsState(
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [fontSize];
}
