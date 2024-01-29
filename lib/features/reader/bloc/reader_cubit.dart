import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/shared/bookmark_object.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_settings.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ChapterObject _chapterObject;
  final ScrollController scrollController = ScrollController();
  double area = 0.0;

  ReaderCubit(this._chapterObject) : super(ReaderState(chapterObject: _chapterObject));

  void initialize() async {
    emit(state.copyWith(
      prevChapterObj: await _getPrevChapter(),
      nextChapterObj: await _getNextChapter(),
      readerSettings: state.readerSettings.load(),
    ));
  }

  void scrollToLastRead() {
    BookmarkObject bookmarkObject = _chapterObject.getBook().bookmarkObject;
    double deviceWidth = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
    scrollController.animateTo(
      bookmarkObject.area / deviceWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Settings
  ReaderSettings setSettings({double? fontSize, double? lineHeight}) {
    ReaderSettings newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
    );
    emit(state.copyWith(readerSettings: newSettings));
    return newSettings;
  }

  void saveSettings({double? fontSize, double? lineHeight}) {
    setSettings(fontSize: fontSize, lineHeight: lineHeight).save();
  }

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettings()..save()));
  }

  /// Chapter
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

  /// Bookmarks
  void saveBookmark() {
    emit(state.copyWith(isAddBookmarkDisabled: true));
    final BookObject bookObject = _chapterObject.getBook();
    bookObject.bookmarkObject = bookObject.bookmarkObject.copyWith(
      chapterNumber: _chapterObject.ordinalNumber,
      area: area,
      savedTime: DateTime.now(),
    );
    bookObject.saveBookmark();
    Future.delayed(const Duration(seconds: 1)).then((_) => emit(state.copyWith(isAddBookmarkDisabled: false)));
  }

  /// Dispose
  void dispose() {
    scrollController.dispose();
  }
}
