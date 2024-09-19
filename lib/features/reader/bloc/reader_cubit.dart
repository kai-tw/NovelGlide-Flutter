import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/book_data.dart';
import '../../../data/bookmark_data.dart';
import '../../../data/file_path.dart';
import '../../../data/reader_settings_data.dart';
import '../../../toolbox/css_helper.dart';
import 'reader_search_cubit.dart';
import 'reader_search_result.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  /// Web Server
  final String _host = 'localhost';
  final int _port = 8080;
  HttpServer? _server;

  /// WebView
  final WebViewController webViewController = WebViewController();

  /// Reader
  BookData? bookData;
  final String bookPath;
  late ThemeData _currentTheme;

  ReaderSearchCubit? searchCubit;

  /// Gestures
  double? startDragX;

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
        return _server != null && request.url.startsWith('http://$_host:$_port') ||
                request.url.startsWith('about:srcdoc')
            ? NavigationDecision.navigate
            : NavigationDecision.prevent;
      },
    ));

    await Future.wait([
      _startWebServer(),
      webViewController.addJavaScriptChannel('appApi', onMessageReceived: _onAppApiMessage),
    ]);
    webViewController.loadRequest(Uri.parse('http://$_host:$_port/'));
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
          _stopWebServer();
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

  /// ******* Web Server Start ********

  Future<void> _startWebServer() async {
    var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    debugPrint('Server listening on port ${_server?.port}');
    _server?.autoCompress = true;
  }

  Future<Response> _echoRequest(Request request) async {
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

      default:
        return Response.notFound('Not found');
    }
  }

  Future<void> _stopWebServer() async {
    if (_server != null) {
      await _server?.close();
      _server = null;
      debugPrint('Server closed');
    }
  }

  /// ******* App Lifecycle ********

  /// Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _stopWebServer();
    }
  }

  /// Cubit
  @override
  Future<void> close() async {
    _stopWebServer();
    super.close();
  }
}
