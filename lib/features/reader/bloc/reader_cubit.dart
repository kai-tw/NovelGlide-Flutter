import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../processor/chapter_processor.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ScrollController scrollController = ScrollController();
  bool isAutoJump;
  double currentArea = 0.0;

  ReaderCubit(String bookName, int chapterNumber, {this.isAutoJump = false})
      : super(ReaderState(bookName: bookName, chapterNumber: chapterNumber));

  void initialize() async {
    final String bookName = state.bookName;
    final int chapterNumber = state.chapterNumber;

    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      prevChapterNumber: ChapterProcessor.getPrevChapterNumber(bookName, chapterNumber),
      nextChapterNumber: ChapterProcessor.getNextChapterNumber(bookName, chapterNumber),
      contentLines: await ChapterProcessor.getContent(bookName, chapterNumber),
      bookmarkData: BookmarkData.fromBookName(bookName),
      readerSettings: ReaderSettingsData.load(),
    ));

    // Scrolling Listener
    scrollController.addListener(_onScroll);
    scrollController.position.isScrollingNotifier.addListener(_onScrollEnd);

    // Entering a different chapter from the bookmark.
    // If the autoSave is enabled, save the bookmark.
    if (state.chapterNumber != state.bookmarkData.chapterNumber) {
      autoSaveBookmark();
    }

    // If the autoSave is enabled or the autoJump is requested,
    // scroll to the bookmark.
    if (state.readerSettings.autoSave || isAutoJump) {
      scrollToBookmark();
      isAutoJump = false;
    }
  }

  void changeChapter(int chapterNumber) {
    emit(ReaderState(bookName: state.bookName, chapterNumber: chapterNumber));
    currentArea = 0.0;
    scrollController.jumpTo(0);
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
    emit(state.copyWith(bookmarkData: bookmarkObject));
  }

  void autoSaveBookmark() {
    if (state.readerSettings.autoSave) {
      saveBookmark();
    }
  }

  void scrollToBookmark() {
    if (state.bookmarkData.chapterNumber == state.chapterNumber) {
      final double deviceWidth =
          MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
      scrollController.animateTo(
        state.bookmarkData.area / deviceWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Future<void> close() async {
    super.close();
    scrollController.dispose();
  }

  void _onScroll() {
    if (state.code != ReaderStateCode.loaded) {
      // The content is not loaded yet.
      return;
    }
    final double deviceWidth =
        MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
    currentArea = scrollController.position.pixels * deviceWidth;
  }

  void _onScrollEnd() {
    if (state.code != ReaderStateCode.loaded) {
      // The content is not loaded yet.
      return;
    }
    if(!scrollController.position.isScrollingNotifier.value) {
      autoSaveBookmark();
    }
  }
}
