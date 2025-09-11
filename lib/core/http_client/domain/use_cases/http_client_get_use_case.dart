import '../../../domain/use_cases/use_case.dart';
import '../repositories/http_client_repository.dart';

class HttpClientGetUseCase extends UseCase<Future<dynamic>, Uri> {
  HttpClientGetUseCase(this._repository);

  final HttpClientRepository _repository;

  @override
  Future<dynamic> call(Uri parameter) {
    return _repository.get(parameter);
  }
}
