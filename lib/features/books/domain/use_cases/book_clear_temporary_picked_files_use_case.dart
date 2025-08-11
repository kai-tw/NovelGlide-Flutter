import '../../../../core/domain/use_cases/use_case.dart';

import '../repositories/book_repository.dart';

class BookClearTemporaryPickedFilesUseCase extends UseCase<void, void> {
  const BookClearTemporaryPickedFilesUseCase(this._repository);

  final BookRepository _repository;

  @override
  void call([void parameter]) {
    _repository.clearTemporaryPickedBooks();
  }
}
