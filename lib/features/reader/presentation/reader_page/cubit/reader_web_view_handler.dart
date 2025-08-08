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
        ReaderWebViewHandler._(repository, controller, uri);

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

  ReaderWebViewHandler._(this._repository, this.controller, this.uri);

  final Uri uri;
  final WebViewController controller;
  final ReaderWebViewRepository _repository;

  Stream<ReaderWebMessageDto> get messages => _repository.messages;

  void send(String route, [Object? data]) {
    _repository.send(ReaderWebMessageDto(route: route, data: data));
  }

  Future<void> request() {
    return controller.loadRequest(uri);
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

  void setSmoothScroll(bool isSmoothScroll) =>
      send('setSmoothScroll', isSmoothScroll);
}
