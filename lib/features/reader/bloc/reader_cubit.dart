import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/book_data.dart';
import '../../../data_model/bookmark_data.dart';
import '../../../data_model/reader_settings_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../enum/reader_loading_state_code.dart';
import '../../../enum/reader_navigation_state_code.dart';
import '../../../repository/book_repository.dart';
import '../../../repository/bookmark_repository.dart';
import '../../../repository/cache_repository.dart';
import '../../../utils/int_utils.dart';
import 'reader_destination_type.dart';
import 'reader_gesture_handler.dart';
import 'reader_search_cubit.dart';
import 'reader_server_handler.dart';
import 'reader_state.dart';
import 'reader_web_view_handler.dart';

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

    late ReaderSettingsData readerSettingsData;
    await Future.wait<dynamic>([
      BookRepository.get(absolutePath).then((value) => bookData = value),
      ReaderSettingsData.load().then((value) => readerSettingsData = value),
      _serverHandler.start(),
      webViewHandler.addAppApiChannel(onAppApiMessage),
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

  /// JavaScript Channel Message Processor
  void onAppApiMessage(JavaScriptMessage message) {
    final request = jsonDecode(message.message);

    switch (request['route']) {
      case 'saveLocation':
        if (bookData != null) {
          CacheRepository.storeLocation(bookPath, request['data']);
        }
        break;

      case 'loadDone':
        if (!isClosed) {
          _serverHandler.stop();
          emit(state.copyWith(code: LoadingStateCode.loaded));
          sendThemeData();
        }
        break;

      case 'setState':
        if (!isClosed) {
          final Map<String, dynamic> jsonValue = request['data'];
          emit(
            state.copyWith(
              atStart: jsonValue['atStart'],
              atEnd: jsonValue['atEnd'],
              breadcrumb: jsonValue['breadcrumb'],
              chapterFileName: jsonValue['chapterFileName'],
              isRtl: jsonValue['isRtl'],
              startCfi: jsonValue['startCfi'],
              chapterCurrentPage:
                  IntUtils.parse(jsonValue['chapterCurrentPage']),
              chapterTotalPage: IntUtils.parse(jsonValue['chapterTotalPage']),
            ),
          );

          if (state.readerSettings.autoSave) {
            saveBookmark();
          }
        }
        break;

      case 'setSearchResultList':
        final Map<String, dynamic> jsonValue = request['data'];
        searchCubit.setResultList(jsonValue['searchResultList']);
        break;

      default:
    }
  }

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code.isLoaded) {
      webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  /// ******* Settings ********

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

  /// ******* Bookmarks ********

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

  void _onLifecycleChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _serverHandler.stop();
        break;
      default:
    }
  }

  @override
  Future<void> close() async {
    await _serverHandler.stop();
    await searchCubit.close();
    _lifecycle.dispose();
    super.close();
  }
}
