import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/reader_settings_data.dart';
import '../../../toolbox/css_helper.dart';
import 'reader_cubit.dart';
import 'reader_web_server_handler.dart';

class ReaderWebViewHandler {
  final ReaderCubit _readerCubit;
  final WebViewController controller = WebViewController();
  late final ReaderWebServerHandler _serverHandler = _readerCubit.serverHandler;

  ReaderWebViewHandler(this._readerCubit);

  void init({String? dest, bool isGotoBookmark = false}) {
    controller.enableZoom(false);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(Colors.transparent);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) => debugPrint('Page started loading: $url'),
      onPageFinished: (url) => _onPageFinished(url, dest: dest, isGotoBookmark: isGotoBookmark),
      onNavigationRequest: _onNavigationRequest,
    ));
  }

  Future<void> addAppApiChannel() async {
    return controller.addJavaScriptChannel('appApi', onMessageReceived: _readerCubit.onAppApiMessage);
  }

  Future<void> request() async {
    return controller.loadRequest(Uri.parse(_serverHandler.url));
  }

  void sendThemeData(ThemeData themeData, ReaderSettingsData settings) {
    final Map<String, dynamic> json = {
      "body": {
        "color": CssHelper.convertColorToCssRgba(themeData.colorScheme.onSurface),
        "font-size": "${settings.fontSize.toStringAsFixed(1)}px",
        "line-height": settings.lineHeight.toStringAsFixed(1),
      },
      "a": {
        "color": "inherit !important",
      }
    };
    controller.runJavaScript('window.readerApi.setThemeData(${jsonEncode(json)})');
  }

  void _onPageFinished(String url, {String? dest, bool isGotoBookmark = false}) async {
    debugPrint('Page finished loading: $url');

    // Construct the appApi channel
    controller.runJavaScript('window.readerApi.setAppApi()');

    if (dest != null) {
      controller.runJavaScript('window.readerApi.main("$dest")');
    } else if (_readerCubit.state.bookmarkData?.startCfi != null && isGotoBookmark ||
        _readerCubit.state.readerSettings.autoSave) {
      controller.runJavaScript('window.readerApi.main("${_readerCubit.state.bookmarkData!.startCfi}")');
    } else {
      controller.runJavaScript('window.readerApi.main()');
    }
  }

  FutureOr<NavigationDecision> _onNavigationRequest(NavigationRequest request) {
    return _serverHandler.isRunning && request.url.startsWith(_serverHandler.url) ||
            request.url.startsWith('about:srcdoc')
        ? NavigationDecision.navigate
        : NavigationDecision.prevent;
  }
}
