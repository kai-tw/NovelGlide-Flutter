import 'dart:async';

import '../../../lifecycle/domain/repositories/lifecycle_repository.dart';
import '../../../log_system/log_system.dart';
import '../../domain/entities/web_server_request.dart';
import '../../domain/entities/web_server_response.dart';
import '../../domain/repositories/web_server_repository.dart';
import '../data_sources/web_server_data_source.dart';

class WebServerRepositoryImpl implements WebServerRepository {
  factory WebServerRepositoryImpl(
    WebServerDataSource serverDataSource,
    LifecycleRepository lifecycleRepository,
  ) {
    final WebServerRepositoryImpl instance = WebServerRepositoryImpl._(
      serverDataSource,
    );

    lifecycleRepository.onDetach.listen((_) => instance.onDetach());

    return instance;
  }

  WebServerRepositoryImpl._(this._serverDataSource);

  final WebServerDataSource _serverDataSource;
  final Set<int> _ports = <int>{};

  @override
  Future<void> start(
    int port,
    Map<String, Future<WebServerResponse> Function(WebServerRequest request)>
        routes,
  ) async {
    if (!_ports.contains(port)) {
      _ports.add(port);
      await _serverDataSource.start(port, routes);
    } else {
      LogSystem.error('Web servers: Port $port is already in use.');
    }
  }

  @override
  Future<void> stop(int port) async {
    if (_ports.contains(port)) {
      _ports.remove(port);
      await _serverDataSource.stop(port);
    }
  }

  Future<void> onDetach() async {
    for (final int port in _ports) {
      await _serverDataSource.stop(port);
    }
  }
}
