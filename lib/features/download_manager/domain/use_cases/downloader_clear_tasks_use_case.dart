import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/downloader_repository.dart';

class DownloaderClearTasksUseCase extends UseCase<Future<void>, void> {
  DownloaderClearTasksUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.clearTasks();
  }
}
