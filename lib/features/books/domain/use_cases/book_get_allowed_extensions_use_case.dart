import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_repository.dart';

class BookGetAllowedExtensionsUseCase extends UseCase<List<String>, void> {
  const BookGetAllowedExtensionsUseCase(this._repository);

  final BookRepository _repository;

  @override
  List<String> call([void parameter]) {
    return _repository.allowedExtensions;
  }
}
