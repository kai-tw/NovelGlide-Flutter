import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_settings.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ChapterObject _chapterObject;
  final ScrollController scrollController = ScrollController();
  double _scrollY = 0.0;
  double _maxScrollY = 0.0;

  ReaderCubit(this._chapterObject) : super(ReaderState(chapterObject: _chapterObject));

  void initialize() async {
    emit(state.copyWith(
      prevChapterObj: await _getPrevChapter(),
      nextChapterObj: await _getNextChapter(),
      readerSettings: state.readerSettings.load(),
    ));
  }

  void scrollToLastRead() {
    scrollController.animateTo(_getLastReadY(), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  /// Settings
  void setSettings({double? fontSize, double? lineHeight}) {
    ReaderSettings newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
    );
    emit(state.copyWith(readerSettings: newSettings));
  }

  void saveSettings({double? fontSize, double? lineHeight}) {
    ReaderSettings newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
    );
    emit(state.copyWith(readerSettings: newSettings));
    newSettings.save();
  }

  void resetSettings() {
    ReaderSettings newSettings = const ReaderSettings();
    emit(state.copyWith(readerSettings: newSettings));
    newSettings.save();
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
  void setScrollY(double value) {
    _scrollY = value.clamp(0.0, _maxScrollY);
  }

  void setMaxScrollY(double value) {
    _maxScrollY = max(_maxScrollY, value);
  }

  void saveBookmark() {
    String bookName = _chapterObject.getBook().name;
    Box bookmarkBox = Hive.box(name: join('bookmarks', bookName));
    bookmarkBox.put(_chapterObject.ordinalNumber.toString(), _scrollY);
    bookmarkBox.close();
    emit(state.copyWith(addBookmarkState: true));
    Future.delayed(const Duration(seconds: 1)).then((_) => _resetAddBookmarkState());
  }

  void _resetAddBookmarkState() {
    if (state.addBookmarkState) {
      emit(state.copyWith(addBookmarkState: false));
    }
  }

  double _getLastReadY() {
    String bookName = _chapterObject.getBook().name;
    Box bookmarkBox = Hive.box(name: join('bookmarks', bookName));
    final double result = bookmarkBox.get(_chapterObject.ordinalNumber.toString(), defaultValue: 0.0);
    bookmarkBox.close();
    return result;
  }

  /// Dispose
  void dispose() {
    scrollController.dispose();
  }
}
