import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/downloader_repository.dart';

class DownloaderGetTaskListUseCase extends UseCase<Future<List<String>>, void> {
  DownloaderGetTaskListUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Future<List<String>> call([void parameter]) {
    return _repository.getTaskList();
  }
}
