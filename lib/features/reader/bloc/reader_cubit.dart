import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../processor/chapter_processor.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();

  ReaderCubit(String bookName, int chapterNumber)
      : super(ReaderState(bookName: bookName, chapterNumber: chapterNumber));

  void initialize({bool isAutoJump = false}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String bookName = state.bookName;
      final int chapterNumber = state.chapterNumber;
      final BookmarkData bookmarkData = BookmarkData.fromBookName(bookName);
      final ReaderSettingsData readerSettings = ReaderSettingsData.load();

      // Scrolling Listener
      scrollController.addListener(_onScroll);
      scrollController.position.isScrollingNotifier.addListener(_onScrollEnd);

      if (!isClosed) {
        emit(ReaderState(
          bookName: bookName,
          chapterNumber: chapterNumber,
          code: ReaderStateCode.loaded,
          prevChapterNumber: await ChapterProcessor.getPrevChapterNumber(bookName, chapterNumber),
          nextChapterNumber: await ChapterProcessor.getNextChapterNumber(bookName, chapterNumber),
          contentLines: await ChapterProcessor.getContent(bookName, chapterNumber, isAutoDecode: false),
          bookmarkData: bookmarkData,
          readerSettings: readerSettings,
        ));
      }

      // After the render is completed, scroll to the bookmark.
      if (bookmarkData.chapterNumber == chapterNumber && (readerSettings.autoSave || isAutoJump)) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          scrollToBookmark();
        });
      } else if (bookmarkData.chapterNumber != chapterNumber && readerSettings.autoSave) {
        saveBookmark();
      }
    });
  }

  void changeChapter(int chapterNumber) async {
    emit(ReaderState(bookName: state.bookName, chapterNumber: chapterNumber));
    scrollController.jumpTo(0);
    if (state.readerSettings.autoSave) {
      saveBookmark();
    }
    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      prevChapterNumber: await ChapterProcessor.getPrevChapterNumber(state.bookName, chapterNumber),
      nextChapterNumber: await ChapterProcessor.getNextChapterNumber(state.bookName, chapterNumber),
      contentLines: await ChapterProcessor.getContent(state.bookName, chapterNumber, isAutoDecode: false),
      readerSettings: ReaderSettingsData.load(),
    ));
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
      scrollPosition: scrollController.position.pixels,
      savedTime: DateTime.now(),
    )..save();
    print('\x1B[34msaveBookmark\x1B[0m');
    emit(state.copyWith(bookmarkData: bookmarkObject));
  }

  void scrollToBookmark() {
    scrollController.animateTo(
      state.bookmarkData.scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
    emit(state.copyWith(
      currentScrollY: scrollController.position.pixels,
      maxScrollExtent: scrollController.position.maxScrollExtent,
    ));
  }

  void _onScrollEnd() {
    if (state.code != ReaderStateCode.loaded) {
      // The content is not loaded yet.
      return;
    }
    if (!scrollController.position.isScrollingNotifier.value) {
      if (state.readerSettings.autoSave) {
        saveBookmark();
      }
    }
  }
}
