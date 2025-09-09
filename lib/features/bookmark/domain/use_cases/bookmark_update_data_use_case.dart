import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/bookmark_data.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkUpdateDataUseCase
    extends UseCase<Future<void>, Set<BookmarkData>> {
  BookmarkUpdateDataUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<void> call(Set<BookmarkData> parameter) {
    return _repository.updateData(parameter);
  }
}
