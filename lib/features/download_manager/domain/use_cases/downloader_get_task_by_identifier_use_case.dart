import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/downloader_task.dart';
import '../repositories/downloader_repository.dart';

class DownloaderGetTaskByIdentifierUseCase
    extends UseCase<Future<DownloaderTask?>, String> {
  DownloaderGetTaskByIdentifierUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Future<DownloaderTask?> call(String parameter) {
    return _repository.getTaskByIdentifier(parameter);
  }
}
