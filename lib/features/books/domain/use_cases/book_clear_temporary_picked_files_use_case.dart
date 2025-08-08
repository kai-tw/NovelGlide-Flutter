import 'package:novel_glide/core/use_cases/use_case.dart';

import '../repository/book_repository.dart';

class BookClearTemporaryPickedFilesUseCase extends UseCase<void, void> {
  const BookClearTemporaryPickedFilesUseCase(this._repository);

  final BookRepository _repository;

  @override
  void call([void parameter]) {
    _repository.clearTemporaryPickedBooks();
  }
}
