import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/downloader_repository.dart';

class DownloaderObserveTaskListChangeUseCase
    extends UseCase<Stream<void>, void> {
  DownloaderObserveTaskListChangeUseCase(this._repository);

  final DownloaderRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onListChangeStream;
  }
}
