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
import '../../../data_model/reader_settings_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/reader_loading_state_code.dart';
import '../../../enum/reader_navigation_state_code.dart';
import '../../../enum/tts_service_state.dart';
import '../../../repository/book_repository.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/cache_repository.dart';
import '../../../services/tts_service.dart';
import '../../../utils/css_utils.dart';
import '../../../utils/int_utils.dart';

part 'reader_destination_type.dart';
part 'reader_gesture_handler.dart';
part 'reader_search_cubit.dart';
part 'reader_server_handler.dart';
part 'reader_state.dart';
part 'reader_tts_handler.dart';
part 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  late final _serverHandler = ReaderServerHandler(bookPath);
  late final webViewHandler = ReaderWebViewHandler(url: _serverHandler.url);
  late final searchCubit = ReaderSearchCubit(
    searchInCurrentChapter: webViewHandler.searchInCurrentChapter,
    searchInWholeBook: webViewHandler.searchInWholeBook,
    goto: webViewHandler.goto,
  );
  late final gestureHandler = ReaderGestureHandler(
    onSwipeLeft: () =>
        state.isRtl ? webViewHandler.nextPage() : webViewHandler.prevPage(),
    onSwipeRight: () =>
        state.isRtl ? webViewHandler.prevPage() : webViewHandler.nextPage(),
  );
  late final _lifecycle =
      AppLifecycleListener(onStateChange: _onLifecycleChanged);

  ReaderCubit({
    required this.currentTheme,
    required this.bookPath,
    this.bookData,
  }) : super(const ReaderState());

  /// Client initialization.
  Future<void> initAsync({
    required ReaderDestinationType destinationType,
    String? destination,
  }) async {
    emit(state.copyWith(
      bookName: bookData?.name,
      code: LoadingStateCode.loading,
      loadingStateCode: ReaderLoadingStateCode.bookLoading,
    ));

    final absolutePath = BookRepository.getAbsolutePath(bookPath);
    final bookmarkData = BookmarkRepository.get(bookPath);

    webViewHandler.initialize(
      destination: destinationType == ReaderDestinationType.bookmark
          ? bookmarkData?.startCfi ?? destination
          : destination,
      savedLocation: CacheRepository.getLocation(bookPath),
    );

    webViewHandler.register('saveLocation', _receiveSaveLocation);
    webViewHandler.register('loadDone', _receiveLoadDone);
    webViewHandler.register('setState', _receiveSetState);
    webViewHandler.register('setSearchResultList', _receiveSetSearchResultList);

    late ReaderSettingsData readerSettingsData;
    await Future.wait<dynamic>([
      BookRepository.get(absolutePath).then((value) => bookData = value),
      ReaderSettingsData.load().then((value) => readerSettingsData = value),
      _serverHandler.start(),
    ]);

    if (isClosed) {
      return;
    }

    emit(state.copyWith(
      loadingStateCode: ReaderLoadingStateCode.rendering,
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
      webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  /// *************************************************************************
  /// Settings
  /// *************************************************************************

  void setSettings({
    double? fontSize,
    double? lineHeight,
    bool? autoSave,
    bool? gestureDetection,
    bool? isSmoothScroll,
    ReaderSettingsPageNumType? pageNumType,
  }) {
    final settings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
      gestureDetection: gestureDetection,
      isSmoothScroll: isSmoothScroll,
      pageNumType: pageNumType,
    );

    emit(state.copyWith(readerSettings: settings));

    if (fontSize != null || lineHeight != null) {
      sendThemeData();
    }

    if (autoSave == true) {
      saveBookmark();
    }

    if (isSmoothScroll != null) {
      webViewHandler.setSmoothScroll(isSmoothScroll);
    }
  }

  void saveSettings() => state.readerSettings.save();

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
    sendThemeData();
  }

  /// *************************************************************************
  /// Bookmarks
  /// *************************************************************************

  Future<void> saveBookmark() async {
    final data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: state.breadcrumb,
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    );

    BookmarkRepository.save(data);

    if (!isClosed) {
      emit(state.copyWith(bookmarkData: data));
    }
  }

  /// *************************************************************************
  /// TTS
  /// *************************************************************************

  late final _ttsHandler = ReaderTTSHandler(onReady: _onTTSServiceReady);

  void _onTTSServiceReady() {
    emit(state.copyWith(ttsState: TtsServiceState.stopped));
    // TODO: Receive the request from the web page.
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

  void _receiveSaveLocation(data) {
    assert(data is String);
    if (bookData != null) {
      CacheRepository.storeLocation(bookPath, data);
    }
  }

  void _receiveLoadDone(_) {
    _serverHandler.stop();
    emit(state.copyWith(code: LoadingStateCode.loaded));
    sendThemeData();
  }

  void _receiveSetState(jsonValue) {
    assert(jsonValue is Map<String, dynamic>);
    emit(
      state.copyWith(
        atStart: jsonValue['atStart'],
        atEnd: jsonValue['atEnd'],
        breadcrumb: jsonValue['breadcrumb'],
        chapterFileName: jsonValue['chapterFileName'],
        isRtl: jsonValue['isRtl'],
        startCfi: jsonValue['startCfi'],
        chapterCurrentPage: IntUtils.parse(jsonValue['chapterCurrentPage']),
        chapterTotalPage: IntUtils.parse(jsonValue['chapterTotalPage']),
      ),
    );

    if (state.readerSettings.autoSave) {
      saveBookmark();
    }
  }

  void _receiveSetSearchResultList(jsonValue) {
    assert(jsonValue is Map<String, dynamic>);
    searchCubit.setResultList(jsonValue['searchResultList']);
  }

  /// *************************************************************************
  /// Miscellaneous
  /// *************************************************************************

  @override
  Future<void> close() async {
    await _serverHandler.stop();
    await searchCubit.close();
    _lifecycle.dispose();
    super.close();
  }
}
