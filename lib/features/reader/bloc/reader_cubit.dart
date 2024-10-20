import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../toolbox/file_path.dart';
import '../../../data/reader_settings_data.dart';
import 'reader_gesture_handler.dart';
import 'reader_lifecycle_handler.dart';
import 'reader_search_cubit.dart';
import 'reader_state.dart';
import 'reader_web_server_handler.dart';
import 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Reader
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  /// Web Server
  late final ReaderWebServerHandler serverHandler =
      ReaderWebServerHandler(bookPath, _logger);

  /// WebView
  late final ReaderWebViewHandler webViewHandler =
      ReaderWebViewHandler(this, _logger);

  /// Search
  late final ReaderSearchCubit searchCubit = ReaderSearchCubit(this, _logger);

  /// Gestures
  late final ReaderGestureHandler gestureHandler = ReaderGestureHandler(this);

  /// AppLifecycleListener
  late final ReaderLifecycleHandler lifecycleHandler =
      ReaderLifecycleHandler(this);

  /// Logger
  final Logger _logger = Logger();

  factory ReaderCubit({
    required String bookPath,
    required ThemeData currentTheme,
    BookData? bookData,
    String? destination,
    bool isGotoBookmark = false,
  }) {
    final initialState = ReaderState(
      bookName: bookData?.name ?? '',
      readerSettings: const ReaderSettingsData(),
    );
    final cubit = ReaderCubit._internal(
      initialState,
      currentTheme: currentTheme,
      bookPath: bookPath,
      bookData: bookData,
    );
    cubit._initialize(destination: destination, isGotoBookmark: isGotoBookmark);
    return cubit;
  }

  ReaderCubit._internal(
    super.initialState, {
    required this.currentTheme,
    required this.bookPath,
    this.bookData,
  });

  /// Client initialization.
  Future<void> _initialize({
    String? destination,
    bool isGotoBookmark = false,
  }) async {
    /// Read the book if it is not read yet.
    if (bookData == null) {
      final absolutePath = absolute(await FilePath.libraryRoot, bookPath);
      final epubBook = await BookData.loadEpubBook(absolutePath);
      bookData = BookData.fromEpubBook(absolutePath, epubBook);
    }

    if (!isClosed) {
      emit(state.copyWith(
        bookName: bookData?.name,
        bookmarkData: await BookmarkData.get(bookPath),
        readerSettings: await ReaderSettingsData.load(),
      ));
    }

    webViewHandler.initialize(
      destination: destination,
      isGotoBookmark: isGotoBookmark,
    );

    await Future.wait([
      serverHandler.start(),
      webViewHandler.addAppApiChannel(),
    ]);
    webViewHandler.request();
  }

  /// JavaScript Channel Message Processor
  void onAppApiMessage(JavaScriptMessage message) async {
    Map<String, dynamic> request = jsonDecode(message.message);
    _logger.i('JS Channel Receive the ${request['route']} request.');

    switch (request['route']) {
      case 'loadDone':
        if (!isClosed) {
          _logger.i('The book has been loaded.');
          serverHandler.stop();
          emit(state.copyWith(code: ReaderStateCode.loaded));
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
              chapterFileName: jsonValue['href'],
              isRtl: jsonValue['isRtl'],
              startCfi: jsonValue['startCfi'],
              localCurrent: jsonValue['localCurrent'],
              localTotal: jsonValue['localTotal'],
            ),
          );

          if (state.code == ReaderStateCode.search &&
              jsonValue['searchResultList'] is List) {
            searchCubit.setResultList(
              jsonValue['searchResultList']
                  .map<ReaderSearchResult>(
                    (e) => ReaderSearchResult(
                      cfi: e['cfi'],
                      excerpt: e['excerpt'],
                    ),
                  )
                  .toList(),
            );
          }

          if (state.readerSettings.autoSave) {
            saveBookmark();
          }
        }
        break;

      case 'log':
        _logger.i(request['data']);
        break;

      default:
        _logger.i('Unknown app api message: $message.');
    }
  }

  /// ******* Communication ********

  void prevPage() =>
      webViewHandler.controller.runJavaScript('window.readerApi.prevPage()');

  void nextPage() =>
      webViewHandler.controller.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) =>
      webViewHandler.controller.runJavaScript('window.readerApi.goto("$cfi")');

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code == ReaderStateCode.loaded) {
      _logger.i('Send the theme data to the renderer.');
      webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  /// ******* Search ********

  void openSearch() {
    _logger.i('Open the search panel.');
    emit(state.copyWith(code: ReaderStateCode.search));
  }

  void closeSearch() {
    _logger.i('Close the search panel.');
    emit(state.copyWith(code: ReaderStateCode.loaded));
  }

  /// ******* Settings ********

  void setSettings(ReaderSettingsData settings) {
    final bool isStyleChanged = state.readerSettings.isStyleChanged(settings);

    emit(state.copyWith(readerSettings: settings));

    if (isStyleChanged) {
      sendThemeData();
    }

    if (settings.autoSave) {
      saveBookmark();
    }
  }

  /// ******* Bookmarks ********

  Future<void> saveBookmark() async {
    _logger.i('Save the bookmark.');
    final chapterTitle =
        (await bookData?.findChapterByFileName(state.chapterFileName))?.title;
    final data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: chapterTitle ?? '-',
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    )..save();

    if (!isClosed) {
      emit(state.copyWith(bookmarkData: data));
    }
  }

  Future<void> scrollToBookmark() async {
    _logger.i('Scroll to the bookmark.');
    final bookmarkData =
        state.bookmarkData ?? await BookmarkData.get(state.bookName);
    if (bookmarkData?.startCfi != null) {
      goto(bookmarkData!.startCfi!);
    }
  }

  @override
  Future<void> close() async {
    await serverHandler.stop();
    await searchCubit.close();
    _logger.close();
    lifecycleHandler.dispose();
    super.close();
  }
}
