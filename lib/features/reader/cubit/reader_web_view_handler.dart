part of 'reader_cubit.dart';

class ReaderWebViewHandler {
  final String url;
  final controller = WebViewController();
  final _channelMap = <String, void Function(dynamic)>{};

  ReaderWebViewHandler({
    required this.url,
  });

  void initialize({String? destination, String? savedLocation}) {
    controller.enableZoom(false);
    controller.setBackgroundColor(Colors.transparent);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.addJavaScriptChannel('appApi', onMessageReceived: receive);

    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) async {
        controller.runJavaScript(
            'window.communicationService.setChannel(window.appApi)');
        send('main', {
          'destination': destination,
          'savedLocation': savedLocation,
        });
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

  void send(String route, [Object? data]) {
    controller.runJavaScript('window.communicationService.receive("$route", '
        '${data != null ? jsonEncode(data) : 'undefined'})');
  }

  void receive(JavaScriptMessage message) {
    Map<String, dynamic> data = jsonDecode(message.message);
    assert(data['route'] is String);
    _channelMap[data['route']]?.call(data['data']);
    debugPrint("Receive: ${data['route']} ${data['data']}");
  }

  void register(String route, void Function(dynamic) handler) {
    _channelMap[route] = handler;
  }

  Future<void> request() {
    return controller.loadRequest(Uri.parse(url));
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void prevPage() => send('prevPage');

  void nextPage() => send('nextPage');

  void goto(String cfi) => send('goto', cfi);

  void sendThemeData(ThemeData themeData, ReaderSettingsData settings) {
    send('setThemeData', {
      "body": {
        "color": CssUtils.convertColorToRgba(themeData.colorScheme.onSurface),
        "font-size": "${settings.fontSize.toStringAsFixed(1)}px",
        "line-height": settings.lineHeight.toStringAsFixed(1),
      },
      "a": {
        "color": "inherit !important",
      },
    });
  }

  void searchInWholeBook(String query) => send('searchInWholeBook', query);

  void searchInCurrentChapter(String query) =>
      send('searchInCurrentChapter', query);

  void setSmoothScroll(bool isSmoothScroll) =>
      send('setSmoothScroll', isSmoothScroll);
}
