part of 'reader_cubit.dart';

class ReaderWebViewHandler {
  ReaderWebViewHandler();

  String? url;
  final WebViewController controller = WebViewController();
  final Map<String, void Function(dynamic p1)> _channelMap =
      <String, void Function(dynamic)>{};

  void initialize({
    required String url,
    String? destination,
    String? savedLocation,
  }) {
    this.url = url;

    controller.enableZoom(false);
    controller.setBackgroundColor(Colors.transparent);
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.addJavaScriptChannel('appApi', onMessageReceived: receive);

    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) async {
        controller.runJavaScript(
            'window.communicationService.setChannel(window.appApi)');
        send('main', <String, String?>{
          'destination': destination,
          'savedLocation': savedLocation,
        });
      },
      onNavigationRequest: (NavigationRequest request) {
        final bool isUrlAllowed = <String>[url, 'about:srcdoc']
            .any((String url) => request.url.startsWith(url));
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
    final Map<String, dynamic> data = jsonDecode(message.message);
    assert(data['route'] is String);
    _channelMap[data['route']]?.call(data['data']);
    LogService.info("Reader: Receive - ${data['route']} ${data['data']}");
  }

  void register(String route, void Function(dynamic) handler) {
    _channelMap[route] = handler;
  }

  Future<void> request() {
    return controller.loadRequest(Uri.parse(url!));
  }

  /// *************************************************************************
  /// Communication
  /// *************************************************************************

  void prevPage() => send('prevPage');

  void nextPage() => send('nextPage');

  void goto(String cfi) => send('goto', cfi);

  void setFontColor(Color color) => send('setFontColor', color.toCssRgba());

  void setFontSize(double fontSize) => send('setFontSize', fontSize);

  void setLineHeight(double lineHeight) => send('setLineHeight', lineHeight);

  void searchInWholeBook(String query) => send('searchInWholeBook', query);

  void searchInCurrentChapter(String query) =>
      send('searchInCurrentChapter', query);

  void setSmoothScroll(bool isSmoothScroll) =>
      send('setSmoothScroll', isSmoothScroll);
}
