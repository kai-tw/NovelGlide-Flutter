import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../../../../core/log_system/log_system.dart';
import '../../../books/domain/use_cases/book_read_bytes_use_case.dart';
import '../../domain/repositories/reader_server_repository.dart';

class ReaderServerRepositoryImpl implements ReaderServerRepository {
  ReaderServerRepositoryImpl(this._bookReadBytesUseCase);

  final Uri _uri = Uri.http('localhost:8080');

  late String _bookIdentifier;
  HttpServer? _server;

  final BookReadBytesUseCase _bookReadBytesUseCase;

  @override
  Future<Uri> start(String bookFilePath) async {
    _bookIdentifier = bookFilePath;
    final Handler handler =
        const Pipeline().addMiddleware(logRequests()).addHandler(_echoRequest);
    _server = await shelf_io.serve(handler, _uri.host, _uri.port);
    _server?.autoCompress = true;
    LogSystem.info('Reader: Server started on ${_uri.host}:${_uri.port}.');

    return _uri;
  }

  Future<Response> _echoRequest(Request request) async {
    switch (request.url.path) {
      case '':
      case 'index.html':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.html'),
          headers: <String, Object>{
            HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'
          },
        );

      case 'index.js':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/index.js'),
          headers: <String, Object>{
            HttpHeaders.contentTypeHeader: 'text/javascript; charset=utf-8'
          },
        );

      case 'main.css':
        return Response.ok(
          await rootBundle.loadString('assets/renderer/main.css'),
          headers: <String, Object>{
            HttpHeaders.contentTypeHeader: 'text/css; charset=utf-8'
          },
        );

      case 'book.epub':
        return Response.ok(
          await _bookReadBytesUseCase(_bookIdentifier),
          headers: <String, Object>{
            HttpHeaders.contentTypeHeader: 'application/epub+zip'
          },
        );

      default:
        return Response.notFound('Not found');
    }
  }

  @override
  Future<void> stop() async {
    if (_server != null) {
      await _server!.close();
      _server = null;
      LogSystem.info('Reader: Server stopped.');
    }
  }
}
