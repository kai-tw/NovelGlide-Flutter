import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../toolbox/file_path.dart';
import '../../../data/reader_settings_data.dart';
import 'reader_gesture_handler.dart';
import 'reader_lifecycle_handler.dart';
import 'reader_search_cubit.dart';
import 'reader_state.dart';
import 'reader_web_server_handler.dart';
import 'reader_web_view_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Web Server
  late final ReaderWebServerHandler serverHandler = ReaderWebServerHandler(bookPath);

  /// WebView
  late final ReaderWebViewHandler webViewHandler = ReaderWebViewHandler(this);

  /// Reader
  final String bookPath;
  BookData? bookData;
  ThemeData currentTheme;

  ReaderSearchCubit? searchCubit;

  /// Gestures
  late final ReaderGestureHandler gestureHandler = ReaderGestureHandler(this);

  /// AppLifecycleListener
  late final ReaderLifecycleHandler lifecycleHandler = ReaderLifecycleHandler(this);

  ReaderCubit({required this.bookPath, this.bookData, required this.currentTheme})
      : super(ReaderState(bookName: bookData?.name ?? '', readerSettings: const ReaderSettingsData()));

  /// Client initialization.
  Future<void> initialize({String? dest, bool isGotoBookmark = false}) async {
    /// Read the book if it is not read yet.
    final absolutePath = isAbsolute(bookPath) ? bookPath : join(await FilePath.libraryRoot, bookPath);
    bookData ??= BookData.fromEpubBook(absolutePath, await BookData.loadEpubBook(absolutePath));

    if (!isClosed) {
      emit(state.copyWith(
        bookName: bookData?.name,
        bookmarkData: await BookmarkData.get(bookPath),
        readerSettings: await ReaderSettingsData.load(),
      ));
    }

    webViewHandler.init(dest: dest, isGotoBookmark: isGotoBookmark);

    await Future.wait([
      serverHandler.start(),
      webViewHandler.addAppApiChannel(),
    ]);
    webViewHandler.request();
  }

  /// ******* App Api Channel ********

  void onAppApiMessage(JavaScriptMessage message) async {
    Map<String, dynamic> request = jsonDecode(message.message);
    switch (request['route']) {
      case 'loadDone':
        if (!isClosed) {
          serverHandler.stop();
          emit(state.copyWith(code: ReaderStateCode.loaded));
          sendThemeData();
        }
        break;

      case 'setState':
        if (!isClosed) {
          final Map<String, dynamic> jsonValue = request['data'];
          emit(state.copyWith(
            atStart: jsonValue['atStart'],
            atEnd: jsonValue['atEnd'],
            chapterFileName: jsonValue['href'],
            isRtl: jsonValue['isRtl'],
            startCfi: jsonValue['startCfi'],
            localCurrent: jsonValue['localCurrent'],
            localTotal: jsonValue['localTotal'],
          ));

          if (searchCubit != null) {
            searchCubit!.setState = searchCubit!.state.copyWith(
              code: LoadingStateCode.loaded,
              searchResultList: (jsonValue['searchResultList'] ?? [])
                  .map<ReaderSearchResult>((e) => ReaderSearchResult(cfi: e['cfi'], excerpt: e['excerpt']))
                  .toList(),
            );
          }

          if (state.readerSettings.autoSave) {
            saveBookmark();
          }
        }
        break;

      case 'log':
        debugPrint(request['data']);
        break;

      default:
        debugPrint('Unknown app api message: $message');
    }
  }

  /// ******* Communication ********

  void prevPage() => webViewHandler.controller.runJavaScript('window.readerApi.prevPage()');

  void nextPage() => webViewHandler.controller.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) => webViewHandler.controller.runJavaScript('window.readerApi.goto("$cfi")');

  void sendThemeData([ThemeData? newTheme]) {
    currentTheme = newTheme ?? currentTheme;
    if (state.code == ReaderStateCode.loaded) {
      webViewHandler.sendThemeData(currentTheme, state.readerSettings);
    }
  }

  /// ******* Search ********

  void openSearch() {
    emit(state.copyWith(code: ReaderStateCode.search));
  }

  void closeSearch() {
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
    final BookmarkData data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: (await bookData?.findChapterByFileName(state.chapterFileName))?.title ?? '-',
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    )..save();

    if (!isClosed) {
      emit(state.copyWith(bookmarkData: data));
    }
  }

  Future<void> scrollToBookmark() async {
    final BookmarkData? bookmarkData = state.bookmarkData ?? await BookmarkData.get(state.bookName);
    if (bookmarkData?.startCfi != null) {
      goto(bookmarkData!.startCfi!);
    }
  }

  @override
  Future<void> close() async {
    serverHandler.stop();
    lifecycleHandler.dispose();
    super.close();
  }
}
