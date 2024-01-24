import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit() : super(const ReaderState());

  void loadSettings() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double? fontSize = readerSetting.get('font_size');
    double? lineHeight = readerSetting.get('line_height');
    readerSetting.close();
    emit(state.copyWith(fontSize: fontSize, lineHeight: lineHeight));
  }

  void set({double? fontSize, double? lineHeight}) {
    emit(state.copyWith(fontSize: fontSize, lineHeight: lineHeight));
  }

  void save({double? fontSize, double? lineHeight}) {
    ReaderState newState = state.copyWith(fontSize: fontSize, lineHeight: lineHeight);

    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.put('font_size', newState.fontSize);
    readerSettings.put('line_height', newState.lineHeight);
    readerSettings.close();

    emit(newState);
  }

  void reset() {
    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.clear();
    readerSettings.close();
    emit(const ReaderState());
  }
}

class ReaderState extends Equatable {
  final double fontSize;
  static const double minFontSize = 12;
  static const double maxFontSize = 32;

  final double lineHeight;
  static const double minLineHeight = 1;
  static const double maxLineHeight = 3;

  const ReaderState({
    this.fontSize = 16,
    this.lineHeight = 1.2,
  });

  ReaderState copyWith({
    double? fontSize,
    double? lineHeight,
  }) {
    return ReaderState(
      fontSize: (fontSize ?? this.fontSize).clamp(minFontSize, maxFontSize),
      lineHeight: (lineHeight ?? this.lineHeight).clamp(minLineHeight, maxLineHeight),
    );
  }

  @override
  List<Object?> get props => [fontSize, lineHeight];
}
