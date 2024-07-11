import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../processor/chapter_processor.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ScrollController scrollController = ScrollController();
  bool isAutoJump;
  double currentScrollY = 0.0;
  double currentArea = 0.0;

  ReaderCubit(String bookName, int chapterNumber, {this.isAutoJump = false})
      : super(ReaderState(bookName: bookName, chapterNumber: chapterNumber));

  void initialize() async {
    final String bookName = state.bookName;
    final int chapterNumber = state.chapterNumber;

    final BookmarkData bookmarkObject = BookmarkData.loadFromBookName(bookName);
    final ReaderSettingsData readerSettings = ReaderSettingsData.load();

    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      prevChapterNumber: ChapterProcessor.getPrevChapterNumber(bookName, chapterNumber),
      nextChapterNumber: ChapterProcessor.getNextChapterNumber(bookName, chapterNumber),
      contentLines: await ChapterProcessor.getContent(bookName, chapterNumber),
      bookmarkObject: bookmarkObject,
      readerSettings: readerSettings,
    ));

    if (state.readerSettings.autoSave || isAutoJump) {
      scrollToBookmark();
    }
  }

  void changeChapter(int chapterNumber) {
    emit(ReaderState(bookName: state.bookName, chapterNumber: chapterNumber));
    scrollController.jumpTo(0);
    isAutoJump = false;
    initialize();
  }

  /// Settings
  void setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    final ReaderSettingsData newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
    );
    emit(state.copyWith(readerSettings: newSettings));
  }

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
  }

  /// Bookmarks
  void saveBookmark() {
    final BookmarkData bookmarkObject = BookmarkData(
      isValid: true,
      bookName: state.bookName,
      chapterNumber: state.chapterNumber,
      area: currentArea,
      savedTime: DateTime.now(),
    )..save();
    emit(state.copyWith(bookmarkObject: bookmarkObject));
  }

  void scrollToBookmark() {
    if (state.bookmarkObject.chapterNumber == state.chapterNumber) {
      final double deviceWidth =
          MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
      scrollController.animateTo(
        state.bookmarkObject.area / deviceWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() async {
    if (state.readerSettings.autoSave) {
      saveBookmark();
    }
    super.close();
    scrollController.dispose();
  }
}
