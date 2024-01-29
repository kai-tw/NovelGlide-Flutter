import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novelglide/shared/bookmark_object.dart';

import '../../../shared/book_object.dart';
import '../../../shared/chapter_object.dart';
import 'reader_button_state.dart';
import 'reader_settings.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final ChapterObject _chapterObject;
  final ScrollController scrollController = ScrollController();
  double currentArea = 0.0;

  ReaderCubit(this._chapterObject) : super(ReaderState(chapterObject: _chapterObject));

  void initialize() async {
    final BookmarkObject bookmarkObject = _chapterObject.getBook().bookmarkObject;
    final ReaderSettings readerSettings = state.readerSettings.load();
    final bool isJumpAvailable = bookmarkObject.isValid && bookmarkObject.chapterNumber == _chapterObject.ordinalNumber;
    emit(state.copyWith(
      prevChapterObj: await _getPrevChapter(),
      nextChapterObj: await _getNextChapter(),
      readerSettings: readerSettings,
      buttonState: state.buttonState.copyWith(
        addBkmState: readerSettings.autoSave ? RdrBtnAddBkmState.disabled : RdrBtnAddBkmState.normal,
        jmpToBkmState: isJumpAvailable ? RdrBtnJmpToBkmState.normal : RdrBtnJmpToBkmState.disabled,
      ),
    ));
  }

  /// Settings
  ReaderSettings setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    final ReaderSettings newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
    );
    final RdrBtnState buttonState = state.buttonState.copyWith(
      addBkmState: newSettings.autoSave ? RdrBtnAddBkmState.disabled : RdrBtnAddBkmState.normal,
    );
    emit(state.copyWith(readerSettings: newSettings, buttonState: buttonState));
    return newSettings;
  }

  void saveSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    setSettings(fontSize: fontSize, lineHeight: lineHeight, autoSave: autoSave).save();
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
    final BookObject bookObject = _chapterObject.getBook();
    bookObject.bookmarkObject = bookObject.bookmarkObject.copyWith(
      chapterNumber: _chapterObject.ordinalNumber,
      area: currentArea,
      savedTime: DateTime.now(),
    );
    bookObject.saveBookmark();
  }

  /// Buttons
  void onClickedAddBkmBtn() {
    final isAutoSave = state.readerSettings.autoSave;
    final RdrBtnAddBkmState defaultAddBkmState = isAutoSave ? RdrBtnAddBkmState.disabled : RdrBtnAddBkmState.normal;

    emit(state.copyWith(buttonState: state.buttonState.copyWith(addBkmState: RdrBtnAddBkmState.clicked)));

    saveBookmark();

    // Activate the jump to bookmark button.
    if (state.buttonState.jmpToBkmState == RdrBtnJmpToBkmState.disabled) {
      emit(state.copyWith(buttonState: state.buttonState.copyWith(jmpToBkmState: RdrBtnJmpToBkmState.normal)));
    }

    // Restore the state of the add bookmark button to default state.
    Future.delayed(const Duration(seconds: 1)).then(
      (_) => emit(state.copyWith(buttonState: state.buttonState.copyWith(addBkmState: defaultAddBkmState))),
    );
  }

  // Trigger on the jump to bookmark button clicked.
  void onClickedJmpToBkmBtn() {
    BookmarkObject bookmarkObject = _chapterObject.getBook().bookmarkObject;
    double deviceWidth = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
    scrollController.animateTo(
      bookmarkObject.area / deviceWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Trigger on the reset button was clicked in the setting page
  void onClickedRstSettingsBtn() {
    resetSettings();
    emit(state.copyWith(buttonState: state.buttonState.copyWith(rstSettingsState: RdrBtnRstSettingsState.clicked)));
    Future.delayed(const Duration(seconds: 1)).then(
      (_) => emit(
          state.copyWith(buttonState: state.buttonState.copyWith(rstSettingsState: RdrBtnRstSettingsState.normal))),
    );
  }

  /// Dispose
  void dispose() {
    scrollController.dispose();
  }
}
