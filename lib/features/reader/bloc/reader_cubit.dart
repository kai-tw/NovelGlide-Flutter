import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../processor/chapter_processor.dart';
import 'reader_button_state.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  bool isAutoJump;
  final ScrollController scrollController = ScrollController();
  double currentArea = 0.0;

  ReaderCubit(String bookName, int chapterNumber, {this.isAutoJump = false})
      : super(ReaderState(bookName: bookName, chapterNumber: chapterNumber));

  void initialize() async {
    final String bookName = state.bookName;
    final int chapterNumber = state.chapterNumber;

    final BookmarkData bookmarkObject = BookmarkData.loadFromBookName(bookName);
    final ReaderSettingsData readerSettings = ReaderSettingsData.load();
    final bool isJumpAvailable =
        !readerSettings.autoSave && bookmarkObject.isValid && bookmarkObject.chapterNumber == chapterNumber;

    emit(state.copyWith(
      code: ReaderStateCode.loaded,
      prevChapterNumber: ChapterProcessor.getPrevChapterNumber(bookName, chapterNumber),
      nextChapterNumber: ChapterProcessor.getNextChapterNumber(bookName, chapterNumber),
      contentLines: await ChapterProcessor.getContent(bookName, chapterNumber),
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
    emit(ReaderState(bookName: state.bookName, chapterNumber: chapterNumber));
    scrollController.jumpTo(0);
    isAutoJump = false;
    initialize();
  }

  /// Settings
  ReaderSettingsData setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    final ReaderSettingsData newSettings = state.readerSettings.copyWith(
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
    emit(state.copyWith(readerSettings: const ReaderSettingsData()..save()));
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

    if (bookmarkObject.chapterNumber == state.chapterNumber) {
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
