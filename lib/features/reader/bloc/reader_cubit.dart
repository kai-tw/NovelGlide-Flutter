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
  final String host = 'localhost';
  final int port = 8080;
  final BookData bookData;
  final WebViewController webViewController = WebViewController();
  HttpServer? server;

  ReaderCubit(this.bookData, int chapterNumber)
      : super(ReaderState(bookName: bookData.name, chapterNumber: chapterNumber));

  Future<void> initialize({bool isAutoJump = false}) async {
    webViewController.enableZoom(false);
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colors.transparent);
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      onHttpError: (HttpResponseError error) {
        final int statusCode = error.response?.statusCode ?? -1;
        print('HTTP error status code: $statusCode');
      },
      onWebResourceError: (WebResourceError error) {
        print('Web resource error: ${error.errorCode}');
      },
      onNavigationRequest: (NavigationRequest request) {
        return request.url.startsWith('http://$host:$port') ? NavigationDecision.navigate : NavigationDecision.prevent;
      },
    ));

    await _startWebServer();
    webViewController.loadRequest(Uri.parse('http://$host:$port/'));

    final String bookName = state.bookName;
    final int chapterNumber = state.chapterNumber;
    final BookmarkData? bookmarkData = BookmarkProcessor.get(bookName);
    final ReaderSettingsData readerSettings = ReaderSettingsData.load();

    emit(ReaderState(
      bookName: bookName,
      chapterNumber: chapterNumber,
      code: ReaderStateCode.loaded,
      bookmarkData: bookmarkData,
      readerSettings: readerSettings,
    ));
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
  }

  Future<Response> _echoRequest(Request request) async {
    print('Server: ${request.url.path}');
    switch (request.url.path) {
      case '':
      case 'index.html':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.html'),
          headers: {HttpHeaders.contentTypeHeader: 'text/html'},
        );

      case 'index.js':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.js'),
          headers: {HttpHeaders.contentTypeHeader: 'text/javascript'},
        );

      case 'main.css':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/main.css'),
          headers: {HttpHeaders.contentTypeHeader: 'text/css'},
        );

      case 'book.epub':
        return Response.ok(
          File(bookData.filePath).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      default:
        return Response.notFound('Not found');
    }
  }

  @override
  Future<void> close() async {
    super.close();
    await server?.close();
    server = null;
    print('Server closed');
  }
}
