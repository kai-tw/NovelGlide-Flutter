import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data_model/reader_settings_data.dart';
import '../../../utils/css_utils.dart';

class ReaderWebViewHandler {
  final String url;
  final controller = WebViewController();

  ReaderWebViewHandler({
    required this.url,
  });

  void initialize({String? destination, String? savedLocation}) {
    controller.enableZoom(false);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(Colors.transparent);

    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) async {
        controller.runJavaScript('window.readerApi.setAppApi()');

        final args = [destination, savedLocation]
            .map((e) => e != null ? "'$e'" : e)
            .join(',');
        controller.runJavaScript('window.readerApi.main($args)');
      },
      onNavigationRequest: (request) {
        final isUrlAllowed =
            [url, 'about:srcdoc'].any((url) => request.url.startsWith(url));
        return isUrlAllowed
            ? NavigationDecision.navigate
            : NavigationDecision.prevent;
      },
    ));
  }

  Future<void> addAppApiChannel(Function(JavaScriptMessage) onMessageReceived) {
    return controller.addJavaScriptChannel(
      'appApi',
      onMessageReceived: onMessageReceived,
    );
  }

  Future<void> request() {
    return controller.loadRequest(Uri.parse(url));
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void prevPage() => controller.runJavaScript('window.readerApi.prevPage()');

  void nextPage() => controller.runJavaScript('window.readerApi.nextPage()');

  void goto(String cfi) =>
      controller.runJavaScript('window.readerApi.goto("$cfi")');

  void sendThemeData(ThemeData themeData, ReaderSettingsData settings) {
    final Map<String, dynamic> json = {
      "body": {
        "color": CssUtils.convertColorToRgba(themeData.colorScheme.onSurface),
        "font-size": "${settings.fontSize.toStringAsFixed(1)}px",
        "line-height": settings.lineHeight.toStringAsFixed(1),
      },
      "a": {
        "color": "inherit !important",
      },
    };
    controller
        .runJavaScript('window.readerApi.setThemeData(${jsonEncode(json)})');
  }

  void searchInWholeBook(String query) {
    controller.runJavaScript('window.readerApi.searchInWholeBook("$query")');
  }

  void searchInCurrentChapter(String query) {
    controller
        .runJavaScript('window.readerApi.searchInCurrentChapter("$query")');
  }

  void setSmoothScroll(bool isSmoothScroll) {
    controller
        .runJavaScript('window.readerApi.setSmoothScroll($isSmoothScroll)');
  }
}
