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

import '../../../../../core/log_system/log_system.dart';
import '../../../../../core/services/preference_service/data/model/reader_preference_data.dart';
import '../../../../../core/services/preference_service/preference_service.dart';
import '../../../../../core/utils/color_extension.dart';
import '../../../../../core/utils/parsers.dart';
import '../../../../book_service/book_service.dart';
import '../../../../bookmark_service/bookmark_service.dart';
import '../../../../tts_service/tts_service.dart';
import '../../../data/model/reader_navigation_state_code.dart';
import '../../../data/model/reader_page_num_type.dart';
import '../../../data/repository/cache_repository.dart';
import '../../search_page/cubit/reader_search_cubit.dart';

part 'reader_destination_type.dart';
part 'reader_gesture_handler.dart';
part 'reader_loading_state_code.dart';
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

  ReaderServerHandler? _serverHandler;
  ReaderWebViewHandler? webViewHandler;
  ReaderSearchCubit? searchCubit;
  ReaderGestureHandler? gestureHandler;
  ReaderTTSHandler? ttsHandler;
  AppLifecycleListener? _lifecycle;

  /// Client initialization.
  Future<void> initAsync({
    required ReaderDestinationType destinationType,
    String? destination,
  }) async {
    // Initialize handlers
    webViewHandler = ReaderWebViewHandler();
    gestureHandler = ReaderGestureHandler(
      onSwipeLeft: previousPage,
      onSwipeRight: nextPage,
    );
    _lifecycle = AppLifecycleListener(onStateChange: _onLifecycleChanged);

    // Initialize
    emit(state.copyWith(
      bookName: bookData?.name,
      code: ReaderLoadingStateCode.bookLoading,
    ));

    // Start loading the data of book, reader settings, and bookmarks.
    late ReaderPreferenceData readerSettingsData;
    late BookmarkData? bookmarkData;
    await Future.wait<void>(<Future<void>>[
      BookService.repository
          .getBookData(bookPath)
          .then((BookData value) => bookData = value),
      PreferenceService.reader
          .load()
          .then((ReaderPreferenceData value) => readerSettingsData = value),
      BookmarkService.repository
          .get(bookPath)
          .then((BookmarkData? data) => bookmarkData = data),
    ]);

    // Start back-end server
    _serverHandler = ReaderServerHandler(bookData!.file);
    await _serverHandler!.start();

    // Initialize webview handler
    webViewHandler!.initialize(
      url: _serverHandler!.url,
      destination: destinationType == ReaderDestinationType.bookmark
          ? bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: await LocationCacheRepository.get(bookPath),
    );

    // Register commands
    webViewHandler!.register('saveLocation', _receiveSaveLocation);
    webViewHandler!.register('loadDone', _receiveLoadDone);
    webViewHandler!.register('setState', _receiveSetState);

    // Initialize search cubit
    searchCubit = ReaderSearchCubit(webViewHandler: webViewHandler!);

    // Initialize TTS handler
    ttsHandler = ReaderTTSHandler(
      webViewHandler: webViewHandler!,
      onTtsStateChanged: _onTtsStateChanged,
    );

    if (isClosed) {
      return;
    }

    // Emit state.
    emit(state.copyWith(
      code: ReaderLoadingStateCode.rendering,
      bookName: bookData?.name,
      bookmarkData: bookmarkData,
      readerPreference: readerSettingsData,
    ));

    // Start loading the page.
    webViewHandler!.request();
  }

  void setNavState(ReaderNavigationStateCode code) {
    emit(state.copyWith(navigationStateCode: code));
  }

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code.isLoaded) {
      webViewHandler!.setFontColor(currentTheme.colorScheme.onSurface);
      webViewHandler!.setFontSize(state.readerPreference.fontSize);
      webViewHandler!.setLineHeight(state.readerPreference.lineHeight);
    }
  }

  /// *************************************************************************
  /// Settings
  /// *************************************************************************

  set fontSize(double value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        fontSize: value,
      ),
    ));
    sendThemeData();
  }

  set lineHeight(double value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        lineHeight: value,
      ),
    ));
    sendThemeData();
  }

  set isAutoSaving(bool value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        isAutoSaving: value,
      ),
    ));
    if (value) {
      saveBookmark();
    }
  }

  set isSmoothScroll(bool value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        isSmoothScroll: value,
      ),
    ));
    webViewHandler!.setSmoothScroll(value);
  }

  set pageNumType(ReaderPageNumType value) {
    emit(state.copyWith(
      readerPreference: state.readerPreference.copyWith(
        pageNumType: value,
      ),
    ));
  }

  void saveSettings() => PreferenceService.reader.save(state.readerPreference);

  Future<void> resetSettings() async {
    await PreferenceService.reader.reset();
    emit(state.copyWith(
      readerPreference: await PreferenceService.reader.load(),
    ));
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

    BookmarkService.repository.updateData(<BookmarkData>{data});

    emit(state.copyWith(bookmarkData: data));
  }

  /// *************************************************************************
  /// Page Navigation
  /// *************************************************************************

  void previousPage() {
    if (!state.ttsState.isStopped) {
      return;
    }
    webViewHandler!.prevPage();
  }

  void nextPage() {
    if (!state.ttsState.isStopped) {
      return;
    }
    webViewHandler!.nextPage();
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
        _serverHandler?.stop();
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
      LocationCacheRepository.store(bookPath, data);
    }
  }

  void _receiveLoadDone(dynamic _) {
    _serverHandler!.stop();
    emit(state.copyWith(code: ReaderLoadingStateCode.loaded));

    // Send theme data after the page is loaded.
    sendThemeData();

    // Set smooth scroll.
    webViewHandler!.setSmoothScroll(state.readerPreference.isSmoothScroll);
  }

  void _receiveSetState(dynamic jsonValue) {
    assert(jsonValue is Map<String, dynamic>);
    emit(state.copyWith(
      breadcrumb: jsonValue['breadcrumb'],
      chapterFileName: jsonValue['chapterFileName'],
      startCfi: jsonValue['startCfi'],
      chapterCurrentPage: parseInt(jsonValue['chapterCurrentPage']),
      chapterTotalPage: parseInt(jsonValue['chapterTotalPage']),
    ));

    if (state.readerPreference.isAutoSaving) {
      saveBookmark();
    }
  }

  /// *************************************************************************
  /// Miscellaneous
  /// *************************************************************************

  @override
  Future<void> close() async {
    await _serverHandler?.stop();
    await searchCubit?.close();
    _lifecycle?.dispose();
    ttsHandler?.dispose();
    super.close();
  }
}
