import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

class ReaderWebServerHandler {
  final String _host = 'localhost';
  final int _port = 8080;
  HttpServer? _server;

  final String _bookPath;

  bool get isRunning => _server != null;
  String get url => 'http://$_host:$_port';

  ReaderWebServerHandler(this._bookPath);

  Future<void> start() async {
    final Handler handler = const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _host, _port);
    debugPrint('Server listening on port ${_server?.port}');
    _server?.autoCompress = true;
  }

  Future<Response> _echoRequest(Request request) async {
    switch (request.url.path) {
      case '':
      case 'index.html':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.html'),
          headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
        );

      case 'index.js':
        return Response.ok(
          await rootBundle.loadString('assets/reader_root/index.js'),
          headers: {HttpHeaders.contentTypeHeader: 'text/javascript; charset=utf-8'},
        );

      case 'main.css':
        String css = await rootBundle.loadString('assets/reader_root/main.css');
        return Response.ok(css, headers: {HttpHeaders.contentTypeHeader: 'text/css; charset=utf-8'});

      case 'book.epub':
        return Response.ok(
          File(_bookPath).readAsBytesSync(),
          headers: {HttpHeaders.contentTypeHeader: 'application/epub+zip'},
        );

      default:
        return Response.notFound('Not found');
    }
  }

  Future<void> stop() async {
    if (_server != null) {
      await _server?.close();
      _server = null;
      debugPrint('Server closed');
    }
  }
}