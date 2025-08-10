import '../../../../core/use_cases/use_case.dart';
import '../entities/bookmark_data.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkGetListUseCase extends UseCase<Future<List<BookmarkData>>, void> {
  BookmarkGetListUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<List<BookmarkData>> call([void parameter]) {
    return _repository.getList();
  }
}
