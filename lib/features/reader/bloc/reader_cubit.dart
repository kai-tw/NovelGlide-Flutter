import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../processor/bookmark_processor.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final BookData bookData;
  final PageStorageBucket bucket = PageStorageBucket();
  final ScrollController scrollController = ScrollController();

  ReaderCubit(this.bookData, int chapterNumber)
      : super(ReaderState(bookName: bookData.name, chapterNumber: chapterNumber));

  void initialize({bool isAutoJump = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String bookName = state.bookName;
      final int chapterNumber = state.chapterNumber;
      final BookmarkData? bookmarkData = BookmarkProcessor.get(bookName);
      final ReaderSettingsData readerSettings = ReaderSettingsData.load();

      emit(ReaderState(
        bookName: bookName,
        chapterNumber: chapterNumber,
        code: ReaderStateCode.loaded,
        prevChapterNumber: chapterNumber - 1 >= 1 ? chapterNumber - 1 : -1,
        nextChapterNumber: chapterNumber + 1 <= bookData.chapterList!.length ? chapterNumber + 1 : -1,
        htmlContent: bookData.chapterList?[chapterNumber - 1].htmlContent ?? "",
        bookmarkData: bookmarkData,
        readerSettings: readerSettings,
      ));

      // After the render is completed, scroll to the bookmark.
      // if (bookmarkData?.chapterNumber == chapterNumber && (readerSettings.autoSave || isAutoJump)) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     scrollToBookmark();
      //   });
      // } else if (bookmarkData?.chapterNumber != chapterNumber && readerSettings.autoSave) {
      //   saveBookmark();
      // }
    });
  }

  void changeChapter(int chapterNumber) async {
    emit(ReaderState(bookName: state.bookName, chapterNumber: chapterNumber));
    // scrollController.jumpTo(0);
    if (state.readerSettings.autoSave) {
      saveBookmark();
    }
    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      prevChapterNumber: chapterNumber - 1 >= 1 ? chapterNumber - 1 : -1,
      nextChapterNumber: chapterNumber + 1 <= bookData.chapterList!.length ? chapterNumber + 1 : -1,
      htmlContent: bookData.chapterList![chapterNumber - 1].htmlContent ?? "",
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
      bookPath: state.bookName,
      chapterNumber: state.chapterNumber,
      // scrollPosition: scrollController.position.pixels,
      scrollPosition: 0,
      savedTime: DateTime.now(),
    )
      ..save();
    emit(state.copyWith(bookmarkData: bookmarkObject));
  }

  void scrollToBookmark() {
    // scrollController.animateTo(
    //   state.bookmarkData?.scrollPosition ?? 0.0,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
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
