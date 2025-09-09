part of 'reader_cubit.dart';

class ReaderWebViewHandler {
  factory ReaderWebViewHandler({
    required WebViewController controller,
    required ReaderWebViewRepository repository,
    required Uri uri,
    String? destination,
    String? savedLocation,
  }) {
    final ReaderWebViewHandler handler =
        ReaderWebViewHandler._(controller, uri);

    // Setup the webview controller.
    controller.enableZoom(false);
    controller.setBackgroundColor(Colors.transparent);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (String url) async {
        repository.setChannel();
        repository.send(ReaderWebMessageDto(
          route: 'main',
          data: <String, String?>{
            'destination': destination,
            'savedLocation': savedLocation,
          },
        ));
      },
      onNavigationRequest: (NavigationRequest request) {
        final bool isUrlAllowed = <String>[uri.toString(), 'about:srcdoc']
            .any((String url) => request.url.startsWith(url));
        return isUrlAllowed
            ? NavigationDecision.navigate
            : NavigationDecision.prevent;
      },
    ));

    return handler;
  }

  ReaderWebViewHandler._(this._controller, this._uri);

  final Uri _uri;
  final WebViewController _controller;

  Future<void> request() {
    return _controller.loadRequest(_uri);
  }
}
