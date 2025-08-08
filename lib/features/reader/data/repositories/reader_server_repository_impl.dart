import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/log_system/log_system.dart';
import '../../domain/repositories/reader_server_repository.dart';

class ReaderServerRepositoryImpl implements ReaderServerRepository {
  ReaderServerRepositoryImpl(this._fileSystemRepository);

  final Uri _uri = Uri.http('localhost:8080');

  late String _bookFilePath;
  HttpServer? _server;

  final FileSystemRepository _fileSystemRepository;

  @override
  Future<Uri> start(String bookFilePath) async {
    _bookFilePath = bookFilePath;
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
          await _fileSystemRepository.readFileAsBytes(_bookFilePath),
          headers: <String, Object>{
            HttpHeaders.contentTypeHeader: 'application/epub+zip'
          },
        );

      default:
        LogSystem.error('Reader: The book at $_bookFilePath is not found.');
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
