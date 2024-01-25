import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../shared/chapter_object.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ChapterObject _chapterObject;

  ReaderCubit(this._chapterObject) : super(ReaderState(chapterObject: _chapterObject));

  void loadSettings() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double? fontSize = readerSetting.get('font_size');
    double? lineHeight = readerSetting.get('line_height');
    readerSetting.close();
    emit(state.copyWith(fontSize: fontSize, lineHeight: lineHeight));
  }

  void setSettings({double? fontSize, double? lineHeight}) {
    emit(state.copyWith(fontSize: fontSize, lineHeight: lineHeight));
  }

  void saveSettings({double? fontSize, double? lineHeight}) {
    ReaderState newState = state.copyWith(fontSize: fontSize, lineHeight: lineHeight);

    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.put('font_size', newState.fontSize);
    readerSettings.put('line_height', newState.lineHeight);
    readerSettings.close();

    emit(newState);
  }

  void resetSettings() {
    Box readerSettings = Hive.box(name: 'reader_settings');
    readerSettings.clear();
    readerSettings.close();
    emit(ReaderState(chapterObject: _chapterObject));
  }
}