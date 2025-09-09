import '../../domain/entities/web_server_request.dart';
import '../../domain/entities/web_server_response.dart';

abstract class WebServerDataSource {
  Future<void> start(
    int port,
    Map<String, Future<WebServerResponse> Function(WebServerRequest request)>
        routes,
  );

  Future<void> stop(int port);
}
