import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ChapterObject _chapterObject;

  ReaderCubit(this._chapterObject) : super(ReaderState(chapterObject: _chapterObject));

  void load() async {
    emit(_loadSettings().copyWith(
      prevChapterObj: await _getPrevChapter(),
      nextChapterObj: await _getNextChapter(),
    ));
  }

  ReaderState _loadSettings() {
    Box readerSetting = Hive.box(name: 'reader_settings');
    double? fontSize = readerSetting.get('font_size');
    double? lineHeight = readerSetting.get('line_height');
    readerSetting.close();
    return state.copyWith(fontSize: fontSize, lineHeight: lineHeight);
  }

  void loadSettings() {
    emit(_loadSettings());
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

  Future<ChapterObject?> _getPrevChapter() async {
    final BookObject bookObject = _chapterObject.getBook();
    final List<ChapterObject> chapterList = await bookObject.getChapterList();
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == _chapterObject.ordinalNumber);

    if (currentIndex > 0) {
      return chapterList[currentIndex - 1];
    }
    return null;
  }

  Future<ChapterObject?> _getNextChapter() async {
    final BookObject bookObject = _chapterObject.getBook();
    final List<ChapterObject> chapterList = await bookObject.getChapterList();
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == _chapterObject.ordinalNumber);

    if (0 <= currentIndex && currentIndex < chapterList.length - 1) {
      return chapterList[currentIndex + 1];
    }
    return null;
  }
}
