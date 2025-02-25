part of 'reader_cubit.dart';

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
