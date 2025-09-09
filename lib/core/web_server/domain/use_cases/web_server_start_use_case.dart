import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/use_case.dart';
import '../entities/web_server_request.dart';
import '../entities/web_server_response.dart';
import '../repositories/web_server_repository.dart';

class WebServerStartUseCaseParam extends Equatable {
  const WebServerStartUseCaseParam({
    required this.port,
    required this.routes,
  });

  final int port;
  final Map<String,
      Future<WebServerResponse> Function(WebServerRequest request)> routes;

  @override
  List<Object?> get props => <Object?>[
        port,
        routes,
      ];
}

class WebServerStartUseCase
    extends UseCase<Future<void>, WebServerStartUseCaseParam> {
  WebServerStartUseCase(this._webServerRepository);

  final WebServerRepository _webServerRepository;

  @override
  Future<void> call(WebServerStartUseCaseParam parameter) {
    return _webServerRepository.start(parameter.port, parameter.routes);
  }
}
