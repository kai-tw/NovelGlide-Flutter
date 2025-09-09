import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/downloader_repository.dart';

class DownloaderCancelTaskUseCase extends UseCase<Future<void>, String> {
  DownloaderCancelTaskUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Future<void> call(String parameter) {
    return _repository.cancelTask(parameter);
  }
}
