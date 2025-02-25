part of 'reader_cubit.dart';

class ReaderServerHandler {
  final _host = 'localhost';
  final _port = 8080;
  final String _bookPath;
  HttpServer? _server;

  String get url => 'http://$_host:$_port';

  ReaderServerHandler(this._bookPath);

  Future<void> start() async {
    final handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    _server?.autoCompress = true;
  }

  Future<Response> _echoRequest(Request request) async {
    switch (request.url.path) {
      case '':
      case 'index.html':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.html'),
          headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
        );

      case 'index.js':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.js'),
          headers: {
            HttpHeaders.contentTypeHeader: 'text/javascript; charset=utf-8'
          },
        );

      case 'main.css':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/main.css'),
          headers: {HttpHeaders.contentTypeHeader: 'text/css; charset=utf-8'},
        );

      case 'book.epub':
        return Response.ok(
          File(BookRepository.getAbsolutePath(_bookPath)).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      default:
        return Response.notFound('Not found');
    }
  }

  /// Stops the web server and releases resources.
  Future<void> stop() async {
    if (_server != null) {
      await _server!.close();
      _server = null;
    }
  }
}
