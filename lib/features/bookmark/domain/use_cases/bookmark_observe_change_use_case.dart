import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkObserveChangeUseCase extends UseCase<Stream<void>, void> {
  BookmarkObserveChangeUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Stream<void> call([void parameter]) {
    return _repository.onChangedStream;
  }
}
