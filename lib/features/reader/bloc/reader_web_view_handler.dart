import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/reader_settings_data.dart';
import '../../../toolbox/css_helper.dart';
import 'reader_cubit.dart';
import 'reader_web_server_handler.dart';

class ReaderWebViewHandler {
  /// The ReaderCubit instance that manages the state of the reader.
  final ReaderCubit _readerCubit;

  /// The WebViewController instance that controls the WebView.
  final WebViewController controller = WebViewController();

  /// The ReaderWebServerHandler instance that handles the web server.
  late final ReaderWebServerHandler _serverHandler = _readerCubit.serverHandler;

  /// The destination URL for navigation.
  String? _destination;

  /// Flag indicating if the navigation is to a bookmark.
  bool _isGotoBookmark = false;

  /// Logger instance for logging events and errors.
  final Logger _logger;

  /// Constructor to initialize the ReaderWebViewHandler with the ReaderCubit and Logger.
  ReaderWebViewHandler(this._readerCubit, this._logger);

  /// Initializes the WebView with optional destination and bookmark flag.
  void initialize({String? destination, bool isGotoBookmark = false}) {
    // Set the destination URL.
    _destination = destination;
    // Set the bookmark flag.
    _isGotoBookmark = isGotoBookmark;

    // Configure the WebView settings.
    // Disable zooming in the WebView.
    controller.enableZoom(false);
    // Allow unrestricted JavaScript execution.
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    // Set the background color to transparent.
    controller.setBackgroundColor(Colors.transparent);

    // Set up the navigation delegate to handle page events.
    controller.setNavigationDelegate(NavigationDelegate(
      // Log when a page starts loading.
      onPageStarted: (url) => _logger.i('Page started loading: $url'),
      // Handle actions when a page finishes loading.
      onPageFinished: _onPageFinished,
      // Handle navigation requests.
      onNavigationRequest: _onNavigationRequest,
      // Log web resource errors.
      onWebResourceError: (error) => _logger.e('Web resource error: $error'),
      // Log HTTP errors.
      onHttpError: (error) => _logger.e('HTTP error: $error'),
    ));
  }

  /// Adds a JavaScript channel for communication between the app and the WebView.
  Future<void> addAppApiChannel() async {
    // Handle messages received from the JavaScript channel.
    return controller.addJavaScriptChannel(
      'appApi',
      onMessageReceived: _readerCubit.onAppApiMessage,
    );
  }

  /// Requests the WebView to load the specified URL from the server.
  Future<void> request() async {
    // Load the server URL in the WebView.
    _logger.i('Request to load: ${_serverHandler.url}');
    return controller.loadRequest(Uri.parse(_serverHandler.url));
  }

  /// Sends theme data to the WebView for styling.
  void sendThemeData(ThemeData themeData, ReaderSettingsData settings) {
    // Construct a JSON object with theme data.
    final Map<String, dynamic> json = {
      "body": {
        // Convert color to CSS RGBA format.
        "color": CssHelper.convertColorToRgba(themeData.colorScheme.onSurface),
        // Set font size.
        "font-size": "${settings.fontSize.toStringAsFixed(1)}px",
        // Set line height.
        "line-height": settings.lineHeight.toStringAsFixed(1),
      },
      // Set link color to inherit.
      "a": {
        "color": "inherit !important",
      }
    };
    // Run JavaScript to set the theme data in the WebView.
    controller
        .runJavaScript('window.readerApi.setThemeData(${jsonEncode(json)})');
  }

  /// Handles actions when a page finishes loading.
  void _onPageFinished(String url) async {
    // Log when a page finishes loading.
    _logger.i('Page finished loading: $url');

    // Construct the appApi channel for communication.
    controller.runJavaScript('window.readerApi.setAppApi()');

    final startCfi = _readerCubit.state.bookmarkData?.startCfi;
    // final isAutoSave = _readerCubit.state.readerSettings.autoSave;

    // Navigate to the specified destination or bookmark.
    if (_destination != null) {
      // Navigate to the destination.
      controller.runJavaScript('window.readerApi.main("$_destination")');
    } else if (startCfi != null && _isGotoBookmark) {
      // Navigate to the bookmark.
      controller.runJavaScript('window.readerApi.main("$startCfi")');
    } else {
      // Default navigation.
      controller.runJavaScript('window.readerApi.main()');
    }
  }

  /// Handles navigation requests and determines if they should be allowed or blocked.
  FutureOr<NavigationDecision> _onNavigationRequest(NavigationRequest request) {
    // Allow navigation if the server is running and the request URL matches the server URL.
    final allowList = [
      _serverHandler.url,
      'about:srcdoc',
    ];
    final isUrlAllowed =
        allowList.firstWhereOrNull((url) => request.url.startsWith(url)) !=
            null;
    final decision = _serverHandler.isRunning && isUrlAllowed
        ? NavigationDecision.navigate // Allow navigation.
        : NavigationDecision.prevent; // Block navigation.

    // Log the decision.
    final messageList = [
      'NavigationDecision: The request for "${request.url}" is $decision.',
      'NavigationDecision: Is server running? ${_serverHandler.isRunning}.',
      'NavigationDecision: Is url allowed?    $isUrlAllowed',
    ];
    for (var log in messageList) {
      _logger.i(log);
    }
    return decision;
  }
}
