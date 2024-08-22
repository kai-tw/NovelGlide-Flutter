import 'dart:async';
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
  final String host = '127.0.0.1';
  final int port = 8080;
  final BookData bookData;
  late final AppLifecycleListener appLifecycleListener;
  final WebViewController webViewController = WebViewController();
  ThemeData currentTheme;
  HttpServer? server;
  bool isServerActive = false;

  ReaderCubit({
    required this.bookData,
    required int chapterNumber,
    required this.currentTheme,
  }) : super(ReaderState(bookName: bookData.name, chapterNumber: chapterNumber));

  Future<void> initialize({bool isAutoJump = false}) async {
    final String bookName = state.bookName;
    final int chapterNumber = state.chapterNumber;
    final BookmarkData? bookmarkData = BookmarkProcessor.get(bookName);
    final ReaderSettingsData readerSettings = ReaderSettingsData.load();

    appLifecycleListener = AppLifecycleListener(onStateChange: _onStateChanged);

    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => print('Page started loading: $url'),
      onPageFinished: (String url) async {
        print('Page finished loading: $url');

        if (!isClosed) {
          emit(ReaderState(
            bookName: bookName,
            chapterNumber: chapterNumber,
            code: ReaderStateCode.loaded,
            bookmarkData: bookmarkData,
            readerSettings: readerSettings,
          ));
        }

        await webViewController.addJavaScriptChannel('ReaderChannel', onMessageReceived: (JavaScriptMessage message) {
          final String messageName = message.message;
          print('Received message: $messageName');
        });
      },
      onHttpError: (HttpResponseError error) => print('HTTP error status code: ${error.response?.statusCode ?? -1}'),
      onWebResourceError: (WebResourceError error) => print('Web resource error: ${error.errorCode}'),
      onNavigationRequest: (NavigationRequest request) =>
          request.url.startsWith('http://$host:$port') ? NavigationDecision.navigate : NavigationDecision.prevent,
    ));

    await _startWebServer();
    webViewController.loadRequest(Uri.parse('http://$host:$port/'));
  }

  /// Contact the web-view to go to the previous page
  void prevPage() {
    webViewController.runJavaScript('window.prevPage()');
  }

  /// Contact the web-view to go to the next page
  void nextPage() {
    webViewController.runJavaScript('window.getState()');
    webViewController.runJavaScript('window.nextPage()');
  }

  /// Settings
  void setSettings({double? fontSize, double? lineHeight, bool? autoSave}) {
    final ReaderSettingsData newSettings = state.readerSettings.copyWith(
      fontSize: fontSize,
      lineHeight: lineHeight,
      autoSave: autoSave,
    );
    emit(state.copyWith(readerSettings: newSettings));
  }

  void resetSettings() {
    emit(state.copyWith(readerSettings: const ReaderSettingsData()));
  }

  /// Bookmarks
  void saveBookmark() {
    // final BookmarkData bookmarkObject = BookmarkData(
    //   bookPath: state.bookName,
    //   chapterNumber: state.chapterNumber,
    //   scrollPosition: 0,
    //   savedTime: DateTime.now(),
    // )
    //   ..save();
    // emit(state.copyWith(bookmarkData: bookmarkObject));
  }

  void scrollToBookmark() {}

  Future<void> _startWebServer() async {
    var handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    server = await shelf_io.serve(handler, host, port);
    print('Server listening on port ${server?.port}');
    server?.autoCompress = true;
    isServerActive = true;
  }

  Future<Response> _echoRequest(Request request) async {
    final HttpConnectionInfo? connectionInfo = request.context['shelf.io.connection_info'] as HttpConnectionInfo?;
    final String? remoteAddress = connectionInfo?.remoteAddress.address;

    if (!isServerActive || remoteAddress != '127.0.0.1') {
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

      case 'data':
        print(await request.readAsString());
        return Response.ok('{}');

      default:
        return Response.notFound('Not found');
    }
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

  void _onResumed() => isServerActive = true;

  void _onInactive() => isServerActive = false;

  void _onHidden() => isServerActive = false;

  void _onPaused() => isServerActive = false;

  @override
  Future<void> close() async {
    super.close();
    await server?.close();
    server = null;
    print('Server closed');
  }
}
