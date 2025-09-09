import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/book_pick_file_data.dart';
import '../repositories/book_repository.dart';

class BookPickUseCase extends UseCase<Future<Set<BookPickFileData>>, void> {
  const BookPickUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<Set<BookPickFileData>> call([void parameter]) {
    return _repository.pickBooks();
  }
}
