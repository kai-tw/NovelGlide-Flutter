import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import '../../../log_system/log_system.dart';
import '../../domain/entities/web_server_request.dart';
import '../../domain/entities/web_server_response.dart';
import 'web_server_data_source.dart';

class ShelfIoServerImpl implements WebServerDataSource {
  final Map<int, HttpServer> _servers = <int, HttpServer>{};

  @override
  Future<void> start(
    int port,
    Map<String, Future<WebServerResponse> Function(WebServerRequest request)>
        routes,
  ) async {
    const String host = 'localhost';
    final Handler handler = const Pipeline()
        .addMiddleware(logRequests())
        .addHandler(_routeMap(routes));
    _servers[port] = await shelf_io.serve(handler, host, port);
    _servers[port]?.autoCompress = true;
    LogSystem.info('Shelf io: Server started on $host:$port.');
  }

  Handler _routeMap(
    Map<String, Future<WebServerResponse> Function(WebServerRequest request)>
        routes,
  ) {
    return (Request request) async {
      final String path = request.url.path;
      if (routes.containsKey(path)) {
        final WebServerResponse responseBody = await routes[path]!.call(
          const WebServerRequest(),
        );

        // Convert to shelf response
        return Response.ok(
          responseBody.body,
          headers: responseBody.headers,
        );
      }
      return Response.notFound('Not Found');
    };
  }

  @override
  Future<void> stop(int port) async {
    if (_servers.containsKey(port)) {
      await _servers[port]?.close();
      _servers.remove(port);
      LogSystem.info('Shelf io: Server on port $port stopped.');
    }
  }
}
