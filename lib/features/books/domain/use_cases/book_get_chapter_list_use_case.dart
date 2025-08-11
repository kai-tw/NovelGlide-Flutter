import '../../../../core/use_cases/use_case.dart';
import '../entities/book_chapter.dart';
import '../repositories/book_repository.dart';

class BookGetChapterListUseCase
    extends UseCase<Future<List<BookChapter>>, String> {
  const BookGetChapterListUseCase(this._repository);

  final BookRepository _repository;

  @override
  Future<List<BookChapter>> call(String parameter) {
    return _repository.getChapterList(parameter);
  }
}
