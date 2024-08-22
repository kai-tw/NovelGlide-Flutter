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
import '../../../processor/bookmark_processor.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final String _host = '127.0.0.1';
  final int _port = 8080;
  final BookData bookData;
  final WebViewController webViewController = WebViewController();

  late ThemeData _currentTheme;

  bool _isAutoJump = false;
  bool _isServerActive = false;
  HttpServer? _server;
  String? _startCfi;

  ReaderCubit({
    required this.bookData,
  }) : super(ReaderState(bookName: bookData.name));

  Future<void> initialize({bool isAutoJump = false}) async {
    _isAutoJump = isAutoJump;

    AppLifecycleListener(onStateChange: _onStateChanged);

    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => print('Page started loading: $url'),
      onPageFinished: (String url) => print('Page finished loading: $url'),
      onHttpError: (HttpResponseError error) => print('HTTP error status code: ${error.response?.statusCode ?? -1}'),
      onWebResourceError: (WebResourceError error) => print('Web resource error: ${error.errorCode}'),
      onNavigationRequest: (NavigationRequest request) =>
          request.url.startsWith('http://$_host:$_port') ? NavigationDecision.navigate : NavigationDecision.prevent,
    ));

    await _startWebServer();
    webViewController.loadRequest(Uri.parse('http://$_host:$_port/'));
  }

  /// Contact the web-view to go to the previous page
  void prevPage() {
    webViewController.runJavaScript('window.prevPage()');
  }

  /// Contact the web-view to go to the next page
  void nextPage() {
    webViewController.runJavaScript('window.nextPage()');
  }

  /// Settings
  void setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    emit(state.copyWith(
      readerSettings: state.readerSettings.copyWith(
        fontSize: fontSize,
        lineHeight: lineHeight,
        autoSave: autoSave,
      ),
    ));
    sendThemeData();
  }

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
    sendThemeData();
  }

  /// Bookmarks
  void saveBookmark() {
    final BookmarkData data = BookmarkData(
      bookPath: bookData.filePath,
      bookName: bookData.name,
      startCfi: _startCfi,
      savedTime: DateTime.now(),
    )..save();
    emit(state.copyWith(bookmarkData: data));
  }

  void scrollToBookmark() {
    final BookmarkData? bookmarkData = state.bookmarkData ?? BookmarkProcessor.get(bookData.name);
    if (bookmarkData?.startCfi != null) {
      webViewController.runJavaScript('window.goToCfi("${bookmarkData!.startCfi}")');
    }
  }

  Future<void> _startWebServer() async {
    var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    print('Server listening on port ${_server?.port}');
    _server?.autoCompress = true;
    _isServerActive = true;
  }

  Future<Response> _echoRequest(Request request) async {
    final HttpConnectionInfo? connectionInfo = request.context['shelf.io.connection_info'] as HttpConnectionInfo?;
    final String? remoteAddress = connectionInfo?.remoteAddress.address;

    if (!_isServerActive || remoteAddress != '127.0.0.1') {
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
          File(bookData.filePath).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      case 'loadDone':
        if (!isClosed) {
          emit(ReaderState(
            bookName: bookData.name,
            code: ReaderStateCode.loaded,
            bookmarkData: BookmarkProcessor.get(bookData.filePath),
            readerSettings: ReaderSettingsData.load(),
          ));

          if (_isAutoJump) {
            scrollToBookmark();
          }
        }
        return Response.ok('{}');

      case 'setState':
        final Map<String, dynamic> jsonValue = jsonDecode(await request.readAsString());

        _startCfi = jsonValue['startCfi'];

        emit(state.copyWith(
          atStart: jsonValue['atStart'],
          atEnd: jsonValue['atEnd'],
        ));

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
    final Color color = _currentTheme.colorScheme.onSurface;
    final Map<String, dynamic> themeData = {
      "body": {
        "color": 'rgba(${color.red}, ${color.green}, ${color.blue}, ${color.alpha / 255})',
        "font-size": state.readerSettings.fontSize.toStringAsFixed(2),
        "line-height": state.readerSettings.lineHeight.toStringAsFixed(1),
      },
      "a": {
        "color": "inherit !important",
      }
    };
    webViewController.runJavaScript('window.setThemeData(${jsonEncode(themeData)})');
  }

  // Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _onPaused();
    }
  }

  void _onDetached() => close();

  void _onResumed() => _isServerActive = true;

  void _onInactive() => _isServerActive = false;

  void _onHidden() => _isServerActive = false;

  void _onPaused() => _isServerActive = false;

  @override
  Future<void> close() async {
    await _server?.close();
    _server = null;
    print('Server closed');
    super.close();
  }
}
