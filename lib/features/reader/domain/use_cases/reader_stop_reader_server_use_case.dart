import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/reader_server_repository.dart';

class ReaderStopReaderServerUseCase extends UseCase<Future<void>, void> {
  const ReaderStopReaderServerUseCase(this._repository);

  final ReaderServerRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.stop();
  }
}
