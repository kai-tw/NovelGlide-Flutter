part of '../reader.dart';

class _WebViewHandler {
  /// The ReaderCubit instance that manages the state of the reader.
  final ReaderCubit readerCubit;

  /// The WebViewController instance that controls the WebView.
  final WebViewController controller = WebViewController();

  /// The ReaderWebServerHandler instance that handles the web server.
  late final _ServerHandler _serverHandler = readerCubit._serverHandler;

  String? _destination;
  String? _savedLocation;

  /// Logger instance for logging events and errors.
  final Logger _logger;

  /// Constructor to initialize the ReaderWebViewHandler with the ReaderCubit and Logger.
  _WebViewHandler(this.readerCubit, this._logger);

  /// Initializes the WebView with optional destination and bookmark flag.
  void initialize({String? destination, String? savedLocation}) {
    _destination = destination;
    _savedLocation = savedLocation;

    // JavaScript Initialization
    controller.enableZoom(false);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(Colors.transparent);

    // Set up the navigation delegate to handle page events.
    controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) => _logger.i('Page started loading: $url'),
      onPageFinished: _onPageFinished,
      onNavigationRequest: _onNavigationRequest,
      onWebResourceError: (error) => _logger
          .e('Web Resource Error: <${error.errorCode}> ${error.description}'),
      onHttpError: (error) => _logger.e(
          'HTTP Error: <${error.response?.statusCode}> ${error.response?.uri}'),
    ));
  }

  /// Adds a JavaScript channel for communication between the app and the WebView.
  Future<void> addAppApiChannel() async {
    // Handle messages received from the JavaScript channel.
    return controller.addJavaScriptChannel(
      'appApi',
      onMessageReceived: readerCubit.onAppApiMessage,
    );
  }

  /// Requests the WebView to load the specified URL from the server.
  Future<void> request() async {
    // Load the server URL in the WebView.
    _logger.i('Request to load: ${_serverHandler.url}');
    return controller.loadRequest(Uri.parse(_serverHandler.url));
  }

  /// Handles actions when a page finishes loading.
  void _onPageFinished(String url) async {
    // Log when a page finishes loading.
    _logger.i('Page finished loading: $url');

    // Construct the appApi channel for communication.
    controller.runJavaScript('window.readerApi.setAppApi()');

    // Navigate to the specified destination or bookmark.
    final args = [_destination, _savedLocation]
        .map((e) => e != null ? "'$e'" : e)
        .join(',');
    controller.runJavaScript('window.readerApi.main($args)');
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
    final decision = isUrlAllowed
        ? NavigationDecision.navigate // Allow navigation.
        : NavigationDecision.prevent; // Block navigation.

    // Log the decision.

    _logger.i(
        'NavigationDecision: The request for "${request.url}" is $decision.\n'
        'NavigationDecision: Is url allowed?    $isUrlAllowed');
    return decision;
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
