import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/reader_settings_data.dart';
import '../../../toolbox/css_helper.dart';
import '../../../toolbox/random_utility.dart';
import 'reader_search_cubit.dart';
import 'reader_search_result.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Web Server
  final String _host = 'localhost';
  final int _port = 8080;
  bool _isServerActive = false;
  HttpServer? _server;

  /// WebView
  final WebViewController webViewController = WebViewController();

  /// Reader
  BookData? bookData;
  final String bookPath;
  late ThemeData _currentTheme;
  String? _authToken;

  ReaderSearchCubit? searchCubit;

  /// Gestures
  double? startDragX;

  ReaderCubit({required this.bookPath, this.bookData})
      : super(ReaderState(
            bookName: bookData?.name ?? '',
            bookmarkData: BookmarkData.get(bookPath),
            readerSettings: ReaderSettingsData.load()));

  /// Client initialization.
  Future<void> initialize({String? gotoDestination, bool isGotoBookmark = false}) async {
    /// Read the book if it is not read yet.
    if (bookData == null) {
      bookData = await BookData.loadEpubBook(bookPath);

      if (!isClosed) {
        emit(state.copyWith(bookName: bookData?.name));
      }
    }

    AppLifecycleListener(onStateChange: _onStateChanged);

    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => debugPrint('Page started loading: $url'),
      onPageFinished: (String url) {
        debugPrint('Page finished loading: $url');
        _authToken = RandomUtility.getRandomString(32);
        webViewController.runJavaScript('window.readerApi.setAuthToken("$_authToken")');
        if (gotoDestination != null) {
          webViewController.runJavaScript('window.readerApi.main("$gotoDestination")');
        } else if (state.bookmarkData?.startCfi != null && isGotoBookmark || state.readerSettings.autoSave) {
          webViewController.runJavaScript('window.readerApi.main("${state.bookmarkData!.startCfi}")');
        } else {
          webViewController.runJavaScript('window.readerApi.main()');
        }
      },
      onNavigationRequest: (NavigationRequest request) =>
          request.url.startsWith('http://$_host:$_port') || request.url.startsWith('about:srcdoc')
              ? NavigationDecision.navigate
              : NavigationDecision.prevent,
    ));

    await _startWebServer();
    webViewController.loadRequest(Uri.parse('http://$_host:$_port/'));
  }

  /// ******* Communication ********

  void prevPage() => webViewController.runJavaScript('window.readerApi.prevPage()');

  void nextPage() => webViewController.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) => webViewController.runJavaScript('window.readerApi.goto("$cfi")');

  /// ******* Search ********

  void openSearch() {
    emit(state.copyWith(code: ReaderStateCode.search));
  }

  void closeSearch() {
    emit(state.copyWith(code: ReaderStateCode.loaded));
  }

  /// ******* Settings ********

  void setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    emit(state.copyWith(
      readerSettings: state.readerSettings.copyWith(
        fontSize: fontSize,
        lineHeight: lineHeight,
        autoSave: autoSave,
      ),
    ));

    if (state.readerSettings.fontSize != fontSize || state.readerSettings.lineHeight != lineHeight) {
      sendThemeData();
    }

    if (autoSave ?? false) {
      saveBookmark();
    }
  }

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
    sendThemeData();
  }

  /// ******* Bookmarks ********

  Future<void> saveBookmark() async {
    final BookmarkData data = BookmarkData(
      bookPath: bookPath,
      bookName: state.bookName,
      chapterTitle: state.chapterTitle,
      chapterFileName: state.chapterFileName,
      startCfi: state.startCfi,
      savedTime: DateTime.now(),
    )..save();
    emit(state.copyWith(bookmarkData: data));
  }

  Future<void> scrollToBookmark() async {
    final BookmarkData? bookmarkData = state.bookmarkData ?? BookmarkData.get(state.bookName);
    if (bookmarkData?.startCfi != null) {
      goto(bookmarkData!.startCfi!);
    }
  }

  /// ******* Web Server Start ********

  Future<void> _startWebServer() async {
    var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    debugPrint('Server listening on port ${_server?.port}');
    _server?.autoCompress = true;
    _isServerActive = true;
  }

  Future<Response> _echoRequest(Request request) async {
    final String clientAuthToken = request.headers['authorization']?.substring(7) ?? '';
    final bool isAuthorized = _authToken != null && clientAuthToken == _authToken && request.method == 'POST';

    if (!_isServerActive) {
      return Response.forbidden('Forbidden');
    }

    switch (request.url.path) {
      case '':
      case 'index.html':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.html'),
          headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
        );

      case 'index.js':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.js'),
          headers: {HttpHeaders.contentTypeHeader: 'text/javascript; charset=utf-8'},
        );

      case 'main.css':
        String css = await rootBundle.loadString('assets/reader_root/main.css');
        return Response.ok(css, headers: {HttpHeaders.contentTypeHeader: 'text/css; charset=utf-8'});

      case 'book.epub':
        return Response.ok(
          File(bookPath).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      case 'loadDone':
        if (!isAuthorized) {
          return Response.forbidden('Forbidden');
        }

        if (!isClosed) {
          emit(state.copyWith(
            code: ReaderStateCode.loaded,
            webResourceError: null,
            httpResponseError: null,
          ));
          sendThemeData();
        }
        return Response.ok('{}');

      case 'setState':
        if (!isAuthorized) {
          return Response.forbidden('Forbidden');
        }

        final Map<String, dynamic> jsonValue = jsonDecode(await request.readAsString());

        if (!isClosed) {
          emit(state.copyWith(
            atStart: jsonValue['atStart'],
            atEnd: jsonValue['atEnd'],
            chapterTitle: bookData?.findChapterByFileName(jsonValue['href'])?.title ?? '',
            chapterFileName: jsonValue['href'],
            startCfi: jsonValue['startCfi'],
            localCurrent: jsonValue['localCurrent'],
            localTotal: jsonValue['localTotal'],
          ));
        }

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

        return Response.ok('{}');

      default:
        return Response.notFound('Not found');
    }
  }

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

  Future<void> _stopWebServer() async {
    if (_server != null) {
      await _server?.close();
      _server = null;
      debugPrint('Server closed');
      _isServerActive = false;
    }
  }

  /// ******* App Lifecycle ********

  /// Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _stopWebServer();
        break;
      case AppLifecycleState.resumed:
        _isServerActive = true;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _isServerActive = false;
        break;
    }
  }

  /// Cubit
  @override
  Future<void> close() async {
    _stopWebServer();
    super.close();
  }
}
