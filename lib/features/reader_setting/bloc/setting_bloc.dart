import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReaderSettingCubit extends Cubit<ReaderSettingState> {
  ReaderSettingCubit(this.readerSettingBox) : super(ReaderSettingState(fontSize: readerSettingBox.get('font_size') ?? 16));

  final Box readerSettingBox;

  void setFontSize(double value) {
    emit(state.copyWith(fontSize: max(state.minFontSize, min(value, state.maxFontSize))));
  }

  void saveFontSize(double value) {
    readerSettingBox.put('font_size', value);
    emit(state.copyWith(fontSize: max(state.minFontSize, min(value, state.maxFontSize))));
  }
}

class ReaderSettingState extends Equatable {
  final double fontSize;
  final double minFontSize = 12;
  final double maxFontSize = 32;

  const ReaderSettingState({
    this.fontSize = 16,
  });

  ReaderSettingState copyWith({
    double? fontSize,
  }) {
    return ReaderSettingState(
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  List<Object?> get props => [fontSize];
}
