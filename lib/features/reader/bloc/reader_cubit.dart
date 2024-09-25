import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/file_path.dart';
import '../../../data/reader_settings_data.dart';
import '../../../toolbox/css_helper.dart';
import 'reader_gesture_handler.dart';
import 'reader_search_cubit.dart';
import 'reader_search_result.dart';
import 'reader_state.dart';
import 'reader_web_server_handler.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Web Server
  late final ReaderWebServerHandler _serverHandler = ReaderWebServerHandler(this, bookPath);

  /// WebView
  final WebViewController webViewController = WebViewController();

  /// Reader
  BookData? bookData;
  final String bookPath;
  late ThemeData _currentTheme;

  ReaderSearchCubit? searchCubit;

  /// Gestures
  late final ReaderGestureHandler gestureHandler = ReaderGestureHandler(this);

  ReaderCubit({required this.bookPath, this.bookData})
      : super(ReaderState(bookName: bookData?.name ?? '', readerSettings: ReaderSettingsData.load()));

  /// Client initialization.
  Future<void> initialize({String? dest, bool isGotoBookmark = false}) async {
    /// Read the book if it is not read yet.
    final absolutePath = isAbsolute(bookPath) ? bookPath : join(await FilePath.libraryRoot, bookPath);
    bookData ??= BookData.fromEpubBook(absolutePath, await BookData.loadEpubBook(absolutePath));
    if (!isClosed) {
      emit(state.copyWith(
        bookName: bookData?.name,
        bookmarkData: await BookmarkData.get(bookPath),
      ));
    }

    AppLifecycleListener(onStateChange: _onStateChanged);

    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => debugPrint('Page started loading: $url'),
      onPageFinished: (url) => _onPageFinished(url, dest: dest, isGotoBookmark: isGotoBookmark),
      onNavigationRequest: (NavigationRequest request) {
        return _serverHandler.isRunning && request.url.startsWith(_serverHandler.url) ||
                request.url.startsWith('about:srcdoc')
            ? NavigationDecision.navigate
            : NavigationDecision.prevent;
      },
    ));

    await Future.wait([
      _serverHandler.start(),
      webViewController.addJavaScriptChannel('appApi', onMessageReceived: _onAppApiMessage),
    ]);
    webViewController.loadRequest(Uri.parse(_serverHandler.url));
  }

  /// ******* WebView Handler ********

  void _onPageFinished(String url, {String? dest, bool isGotoBookmark = false}) async {
    debugPrint('Page finished loading: $url');

    // Construct the appApi channel
    webViewController.runJavaScript('window.readerApi.setAppApi()');

    if (dest != null) {
      webViewController.runJavaScript('window.readerApi.main("$dest")');
    } else if (state.bookmarkData?.startCfi != null && isGotoBookmark || state.readerSettings.autoSave) {
      webViewController.runJavaScript('window.readerApi.main("${state.bookmarkData!.startCfi}")');
    } else {
      webViewController.runJavaScript('window.readerApi.main()');
    }
  }

  /// ******* App Api Channel ********

  void _onAppApiMessage(JavaScriptMessage message) async {
    Map<String, dynamic> request = jsonDecode(message.message);
    switch (request['route']) {
      case 'loadDone':
        if (!isClosed) {
          _serverHandler.stop();
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
              code: ReaderSearchStateCode.loaded,
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

  void prevPage() => webViewController.runJavaScript('window.readerApi.prevPage()');

  void nextPage() => webViewController.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) => webViewController.runJavaScript('window.readerApi.goto("$cfi")');

  void sendThemeData([ThemeData? newTheme]) {
    _currentTheme = newTheme ?? _currentTheme;
    if (state.code == ReaderStateCode.loaded) {
      final Map<String, dynamic> themeData = {
        "body": {
          "color": CssHelper.convertColorToCssRgba(_currentTheme.colorScheme.onSurface),
          "font-size": "${state.readerSettings.fontSize.toStringAsFixed(1)}px",
          "line-height": state.readerSettings.lineHeight.toStringAsFixed(1),
        },
        "a": {
          "color": "inherit !important",
        }
      };
      webViewController.runJavaScript('window.readerApi.setThemeData(${jsonEncode(themeData)})');
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
    emit(state.copyWith(
      readerSettings: settings,
    ));

    if (state.readerSettings.fontSize != settings.fontSize || state.readerSettings.lineHeight != settings.lineHeight) {
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

  /// ******* App Lifecycle ********

  /// Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _serverHandler.stop();
    }
  }

  /// Cubit
  @override
  Future<void> close() async {
    _serverHandler.stop();
    super.close();
  }
}
