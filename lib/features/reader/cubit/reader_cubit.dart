import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/book_data.dart';
import '../../../data_model/bookmark_data.dart';
import '../../../data_model/reader_settings/reader_settings_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/reader_navigation_state_code.dart';
import '../../../repository/book_repository.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/cache_repository/cache_repository.dart';
import '../../../services/tts/tts_service.dart';
import '../../../utils/css_utils.dart';
import '../../../utils/int_utils.dart';

part 'reader_destination_type.dart';
part 'reader_gesture_handler.dart';
part 'reader_loading_state_code.dart';
part 'reader_search_cubit.dart';
part 'reader_search_range_code.dart';
part 'reader_search_result_data.dart';
part 'reader_search_state.dart';
part 'reader_server_handler.dart';
part 'reader_state.dart';
part 'reader_tts_handler.dart';
part 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit({
    required this.currentTheme,
    required this.bookPath,
    this.bookData,
  }) : super(const ReaderState());
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  late final ReaderServerHandler _serverHandler = ReaderServerHandler(bookPath);
  late final ReaderWebViewHandler webViewHandler =
      ReaderWebViewHandler(url: _serverHandler.url);
  late final ReaderSearchCubit searchCubit =
      ReaderSearchCubit(webViewHandler: webViewHandler);
  late final ReaderGestureHandler gestureHandler = ReaderGestureHandler(
    onSwipeLeft: previousPage,
    onSwipeRight: nextPage,
  );
  late final ReaderTTSHandler ttsHandler;
  late final AppLifecycleListener _lifecycle =
      AppLifecycleListener(onStateChange: _onLifecycleChanged);

  /// Client initialization.
  Future<void> initAsync({
    required ReaderDestinationType destinationType,
    String? destination,
  }) async {
    emit(state.copyWith(
      bookName: bookData?.name,
      code: ReaderLoadingStateCode.bookLoading,
    ));

    final String absolutePath = BookRepository.getAbsolutePath(bookPath);
    final BookmarkData? bookmarkData = BookmarkRepository.get(bookPath);

    webViewHandler.initialize(
      destination: destinationType == ReaderDestinationType.bookmark
          ? bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: CacheRepository.locationCache.get(bookPath),
    );

    webViewHandler.register('saveLocation', _receiveSaveLocation);
    webViewHandler.register('loadDone', _receiveLoadDone);
    webViewHandler.register('setState', _receiveSetState);

    ttsHandler = ReaderTTSHandler(
      webViewHandler: webViewHandler,
      onTtsStateChanged: _onTtsStateChanged,
    );

    late ReaderSettingsData readerSettingsData;
    await Future.wait<void>(<Future<void>>[
      BookRepository.get(absolutePath)
          .then((BookData value) => bookData = value),
      ReaderSettingsData.load()
          .then((ReaderSettingsData value) => readerSettingsData = value),
      _serverHandler.start(),
    ]);

    if (isClosed) {
      return;
    }

    emit(state.copyWith(
      code: ReaderLoadingStateCode.rendering,
      bookName: bookData?.name,
      bookmarkData: bookmarkData,
      readerSettings: readerSettingsData,
    ));

    webViewHandler.request();
  }

  void setNavState(ReaderNavigationStateCode code) {
    emit(state.copyWith(navigationStateCode: code));
  }

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code.isLoaded) {
      webViewHandler.setFontColor(
          CssUtils.convertColorToRgba(currentTheme.colorScheme.onSurface));
      webViewHandler.setFontSize(state.readerSettings.fontSize);
      webViewHandler.setLineHeight(state.readerSettings.lineHeight);
    }
  }

  /// *************************************************************************
  /// Settings
  /// *************************************************************************

  set fontSize(double value) {
    emit(state.copyWith(
        readerSettings: state.readerSettings.copyWith(fontSize: value)));
    sendThemeData();
  }

  set lineHeight(double value) {
    emit(state.copyWith(
        readerSettings: state.readerSettings.copyWith(lineHeight: value)));
    sendThemeData();
  }

  set isAutoSaving(bool value) {
    emit(state.copyWith(
        readerSettings: state.readerSettings.copyWith(isAutoSaving: value)));
    if (value) {
      saveBookmark();
    }
  }

  set isSmoothScroll(bool value) {
    emit(state.copyWith(
        readerSettings: state.readerSettings.copyWith(isSmoothScroll: value)));
    webViewHandler.setSmoothScroll(value);
  }

  set pageNumType(ReaderSettingsPageNumType value) {
    emit(state.copyWith(
        readerSettings: state.readerSettings.copyWith(pageNumType: value)));
  }

  void saveSettings() => state.readerSettings.save();

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
    sendThemeData();
  }

  /// *************************************************************************
  /// Bookmarks
  /// *************************************************************************

  void saveBookmark() {
    final BookmarkData data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: state.breadcrumb,
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    );

    BookmarkRepository.save(data);

    emit(state.copyWith(bookmarkData: data));
  }

  /// *************************************************************************
  /// Page Navigation
  /// *************************************************************************

  void previousPage() {
    if (!state.ttsState.isStopped) {
      return;
    }
    webViewHandler.prevPage();
  }

  void nextPage() {
    if (!state.ttsState.isStopped) {
      return;
    }
    webViewHandler.nextPage();
  }

  /// *************************************************************************
  /// TTS
  /// *************************************************************************

  void _onTtsStateChanged(TtsServiceState ttsState) {
    if (!isClosed) {
      emit(state.copyWith(ttsState: ttsState));
    }
  }

  /// *************************************************************************
  /// Lifecycle
  /// *************************************************************************

  void _onLifecycleChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _serverHandler.stop();
        break;
      default:
    }
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void _receiveSaveLocation(dynamic data) {
    assert(data is String);
    if (bookData != null) {
      CacheRepository.locationCache.store(bookPath, data);
    }
  }

  void _receiveLoadDone(_) {
    _serverHandler.stop();
    emit(state.copyWith(code: ReaderLoadingStateCode.loaded));

    // Send theme data after the page is loaded.
    sendThemeData();

    // Set smooth scroll.
    webViewHandler.setSmoothScroll(state.readerSettings.isSmoothScroll);
  }

  void _receiveSetState(dynamic jsonValue) {
    assert(jsonValue is Map<String, dynamic>);
    emit(state.copyWith(
      breadcrumb: jsonValue['breadcrumb'],
      chapterFileName: jsonValue['chapterFileName'],
      startCfi: jsonValue['startCfi'],
      chapterCurrentPage: IntUtils.parse(jsonValue['chapterCurrentPage']),
      chapterTotalPage: IntUtils.parse(jsonValue['chapterTotalPage']),
    ));

    if (state.readerSettings.isAutoSaving) {
      saveBookmark();
    }
  }

  /// *************************************************************************
  /// Miscellaneous
  /// *************************************************************************

  @override
  Future<void> close() async {
    await _serverHandler.stop();
    await searchCubit.close();
    _lifecycle.dispose();
    ttsHandler.dispose();
    super.close();
  }
}
