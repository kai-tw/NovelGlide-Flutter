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
import 'reader_search_cubit.dart';
import 'reader_search_result.dart';
import 'reader_state.dart';

class ReaderCubit extends Cubit<ReaderState> {
  final String _host = 'localhost';
  final int _port = 8080;
  final BookData bookData;

  final WebViewController webViewController = WebViewController();
  late ThemeData _currentTheme;
  String? _startCfi;
  bool _isServerActive = false;
  HttpServer? _server;

  ReaderSearchCubit? searchCubit;

  ReaderCubit({
    required this.bookData,
  }) : super(ReaderState(
          bookName: bookData.name,
          bookmarkData: BookmarkProcessor.get(bookData.filePath),
          readerSettings: ReaderSettingsData.load(),
        ));

  /// Client initialization.
  Future<void> initialize({String? gotoDestination, bool isGotoBookmark = false}) async {
    AppLifecycleListener(onStateChange: _onStateChanged);

    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => debugPrint('Page started loading: $url'),
      onPageFinished: (String url) {
        debugPrint('Page finished loading: $url');
        if (gotoDestination != null) {
          webViewController.runJavaScript('window.readerApi.main("$gotoDestination")');
        } else if (state.bookmarkData?.startCfi != null && isGotoBookmark || state.readerSettings.autoSave) {
          webViewController.runJavaScript('window.readerApi.main("${state.bookmarkData!.startCfi}")');
        } else {
          webViewController.runJavaScript('window.readerApi.main()');
        }
        sendThemeData();
      },
      onHttpError: (HttpResponseError error) =>
          emit(state.copyWith(code: ReaderStateCode.httpResponseError, httpResponseError: error)),
      onWebResourceError: (WebResourceError error) =>
          emit(state.copyWith(code: ReaderStateCode.webResourceError, webResourceError: error)),
      onNavigationRequest: (NavigationRequest request) =>
          request.url.startsWith('http://$_host:$_port') ? NavigationDecision.navigate : NavigationDecision.prevent,
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
      goto(bookmarkData!.startCfi!);
    }
  }

  /// ******* Web Server Start ********

  /// Start the web server.
  Future<void> _startWebServer() async {
    var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    debugPrint('Server listening on port ${_server?.port}');
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

      case 'favicon.ico':
        return Response.ok('');

      case 'loadDone':
        if (!isClosed) {
          emit(state.copyWith(
            code: ReaderStateCode.loaded,
            webResourceError: null,
            httpResponseError: null,
          ));
        }
        return Response.ok('{}');

      case 'setState':
        final Map<String, dynamic> jsonValue = jsonDecode(await request.readAsString());

        _startCfi = jsonValue['startCfi'];

        emit(state.copyWith(
          atStart: jsonValue['atStart'],
          atEnd: jsonValue['atEnd'],
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
        return Response.ok('{}');

      case 'error':
        debugPrint('Error: ${await request.readAsString()}');
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
    webViewController.runJavaScript('window.readerApi.setThemeData(${jsonEncode(themeData)})');
  }

  /// ******* App Lifecycle ********

  /// Listen to the app lifecycle state changes
  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        close();
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
    await _server?.close();
    _server = null;
    debugPrint('Server closed');
    super.close();
  }
}
