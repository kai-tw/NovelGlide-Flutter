import '../../../../core/domain/use_cases/use_case.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkResetUseCase extends UseCase<Future<void>, void> {
  BookmarkResetUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.reset();
  }
}
