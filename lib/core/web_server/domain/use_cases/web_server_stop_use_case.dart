import '../../../domain/use_cases/use_case.dart';
import '../repositories/web_server_repository.dart';

class WebServerStopUseCase extends UseCase<Future<void>, int> {
  WebServerStopUseCase(this._webServerRepository);

  final WebServerRepository _webServerRepository;

  @override
  Future<void> call(int parameter) {
    return _webServerRepository.stop(parameter);
  }
}
