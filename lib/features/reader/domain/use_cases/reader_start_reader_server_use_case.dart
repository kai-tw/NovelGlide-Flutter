import '../../../../core/use_cases/use_case.dart';
import '../repositories/reader_server_repository.dart';

class ReaderStartReaderServerUseCase extends UseCase<Future<Uri>, String> {
  const ReaderStartReaderServerUseCase(this._repository);

  final ReaderServerRepository _repository;

  @override
  Future<Uri> call(String parameter) {
    return _repository.start(parameter);
  }
}
