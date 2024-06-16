import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/chapter_data.dart';
import '../../../toolbox/chapter_processor.dart';
import 'reader_button_state.dart';
import 'reader_settings.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final String _bookName;
  int _chapterNumber;
  bool isAutoJump;
  final ScrollController scrollController = ScrollController();
  double currentArea = 0.0;

  ReaderCubit(this._bookName, this._chapterNumber, {this.isAutoJump = false})
      : super(ReaderState(bookName: _bookName, chapterNumber: _chapterNumber));

  void initialize() async {
    emit(ReaderState(bookName: _bookName, chapterNumber: _chapterNumber));

    final BookmarkData bookmarkObject = BookmarkData.loadFromBookName(_bookName);
    final ReaderSettings readerSettings = state.readerSettings.load();
    final bool isJumpAvailable =
        !readerSettings.autoSave && bookmarkObject.isValid && bookmarkObject.chapterNumber == _chapterNumber;
    final int prevChapterNumber = await _getPrevChapterNumber();
    final int nextChapterNumber = await _getNextChapterNumber();
    final List<String> contentLines =
        await ChapterData(bookName: _bookName, ordinalNumber: _chapterNumber).getContent();

    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      chapterNumber: _chapterNumber,
      prevChapterNumber: prevChapterNumber,
      nextChapterNumber: nextChapterNumber,
      contentLines: contentLines,
      bookmarkObject: bookmarkObject,
      readerSettings: readerSettings,
      buttonState: state.buttonState.copyWith(
        addBkmState: readerSettings.autoSave ? RdrBtnAddBkmState.disabled : RdrBtnAddBkmState.normal,
        jmpToBkmState: isJumpAvailable ? RdrBtnJmpToBkmState.normal : RdrBtnJmpToBkmState.disabled,
        rstSettingsState: RdrBtnRstSettingsState.normal,
      ),
    ));

    if (state.readerSettings.autoSave || isAutoJump) {
      onClickedJmpToBkmBtn();
    }
  }

  void changeChapter(int chapterNumber) {
    _chapterNumber = chapterNumber;
    scrollController.jumpTo(0);
    isAutoJump = false;
    initialize();
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
      jmpToBkmState: newSettings.autoSave ? RdrBtnJmpToBkmState.disabled : RdrBtnJmpToBkmState.normal,
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
  Future<int> _getPrevChapterNumber() async {
    final List<ChapterData> chapterList = ChapterProcessor.getList(_bookName);
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == _chapterNumber);

    if (currentIndex > 0) {
      return chapterList[currentIndex - 1].ordinalNumber;
    }
    return -1;
  }

  Future<int> _getNextChapterNumber() async {
    final List<ChapterData> chapterList = ChapterProcessor.getList(_bookName);
    int currentIndex = chapterList.indexWhere((obj) => obj.ordinalNumber == _chapterNumber);

    if (0 <= currentIndex && currentIndex < chapterList.length - 1) {
      return chapterList[currentIndex + 1].ordinalNumber;
    }
    return -1;
  }

  /// Bookmarks
  void saveBookmark() {
    final BookmarkData bookmarkObject = BookmarkData(
      isValid: true,
      bookName: _bookName,
      chapterNumber: _chapterNumber,
      area: currentArea,
      savedTime: DateTime.now(),
    )..save();
    emit(state.copyWith(bookmarkObject: bookmarkObject));
  }

  /// Buttons
  void _emitButtonState({
    RdrBtnAddBkmState? addBkmState,
    RdrBtnJmpToBkmState? jmpToBkmState,
    RdrBtnRstSettingsState? rstSettingsState,
  }) {
    emit(
      state.copyWith(
        buttonState: state.buttonState.copyWith(
          addBkmState: addBkmState,
          jmpToBkmState: jmpToBkmState,
          rstSettingsState: rstSettingsState,
        ),
      ),
    );
  }

  void onClickedAddBkmBtn() {
    final bool isAutoSave = state.readerSettings.autoSave;
    final RdrBtnAddBkmState defaultAddBkmState = isAutoSave ? RdrBtnAddBkmState.disabled : RdrBtnAddBkmState.normal;

    if (!isAutoSave) {
      _emitButtonState(addBkmState: RdrBtnAddBkmState.disabled);

      saveBookmark();

      _emitButtonState(
        addBkmState: RdrBtnAddBkmState.done,
        jmpToBkmState: RdrBtnJmpToBkmState.normal,
      );

      // Restore the state of the add bookmark button to default state.
      Future.delayed(const Duration(seconds: 1)).then(
        (_) => _emitButtonState(addBkmState: defaultAddBkmState),
      );
    } else {
      _emitButtonState(addBkmState: RdrBtnAddBkmState.disabled);
    }
  }

  // Trigger on the jump to bookmark button clicked.
  void onClickedJmpToBkmBtn() {
    BookmarkData bookmarkObject = state.bookmarkObject;

    if (bookmarkObject.chapterNumber == _chapterNumber) {
      double deviceWidth = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single).size.width;
      scrollController.animateTo(
        bookmarkObject.area / deviceWidth,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _emitButtonState(jmpToBkmState: RdrBtnJmpToBkmState.disabled);
    }
  }

  // Trigger on the reset button was clicked in the setting page
  void onClickedRstSettingsBtn() {
    resetSettings();
    _emitButtonState(rstSettingsState: RdrBtnRstSettingsState.done);
    Future.delayed(const Duration(seconds: 1)).then(
      (_) => _emitButtonState(rstSettingsState: RdrBtnRstSettingsState.normal),
    );
  }

  void dispose() {
    scrollController.dispose();
  }
}
