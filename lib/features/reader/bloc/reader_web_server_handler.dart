import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ReaderWebServerHandler {
  /// The host address for the web server (localhost).
  final String _host = 'localhost';

  /// The port number for the web server (8080).
  final int _port = 8080;

  /// The HTTP server instance that will handle requests.
  HttpServer? _server;

  /// The file path to the book (EPUB) that will be served.
  final String _bookPath;

  /// Getter to retrieve the URL of the running server.
  String get url => 'http://$_host:$_port';

  /// Logger instance for logging server events.
  final Logger _logger;

  /// Constructor to initialize the book path and logger.
  ReaderWebServerHandler(this._bookPath, this._logger);

  /// Starts the web server and sets up request handling.
  Future<void> start() async {
    // Create a handler that logs requests and processes them.
    final Handler handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    // Start the server and listen on the specified host and port.
    _server = await shelf_io.serve(handler, _host, _port);
    // Log the server start event with the port number.
    _logger.i('Server listening on port ${_server?.port}.');
    // Enable automatic response compression for the server.
    _server?.autoCompress = true;
  }

  /// Handles incoming HTTP requests and serves appropriate responses.
  Future<Response> _echoRequest(Request request) async {
    switch (request.url.path) {
      case '':
      case 'index.html':
        // Serve the index.html file for the root path or index.html request.
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.html'),
          headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
        );

      case 'index.js':
        // Serve the index.js file for JavaScript functionality.
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.js'),
          headers: {
            HttpHeaders.contentTypeHeader: 'text/javascript; charset=utf-8'
          },
        );

      case 'main.css':
        // Serve the main.css file for styling.
        String css = await rootBundle.loadString('assets/renderer/main.css');
        return Response.ok(css, headers: {
          HttpHeaders.contentTypeHeader: 'text/css; charset=utf-8'
        });

      case 'book.epub':
        // Serve the EPUB book file from the specified book path.
        return Response.ok(
          File(_bookPath).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      default:
        // Return a 404 Not Found response for unrecognized paths.
        return Response.notFound('Not found');
    }
  }

  /// Stops the web server and releases resources.
  Future<void> stop() async {
    if (_server != null) {
      // Close the server to stop listening for requests.
      await _server?.close();
      // Set the server instance to null to indicate it's stopped.
      _server = null;
      // Log the server stop event.
      _logger.i('Server closed.');
    }
  }
}
