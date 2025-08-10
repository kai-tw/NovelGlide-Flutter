import '../../../../core/use_cases/use_case.dart';
import '../entities/bookmark_data.dart';
import '../repositories/bookmark_repository.dart';

class BookmarkGetDataUseCase extends UseCase<Future<BookmarkData?>, String> {
  BookmarkGetDataUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<BookmarkData?> call(String parameter) {
    return _repository.getDataById(parameter);
  }
}
