import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/downloader_repository.dart';

class DownloaderRemoveTaskUseCase extends UseCase<Future<void>, String> {
  DownloaderRemoveTaskUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Future<void> call(String parameter) {
    return _repository.removeTask(parameter);
  }
}
