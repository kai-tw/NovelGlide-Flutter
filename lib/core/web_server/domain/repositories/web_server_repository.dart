import '../entities/web_server_request.dart';
import '../entities/web_server_response.dart';

abstract class WebServerRepository {
  Future<void> start(
    int port,
    Map<String, Future<WebServerResponse> Function(WebServerRequest request)>
        routes,
  );

  Future<void> stop(int port);
}
