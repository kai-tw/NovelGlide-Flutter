import '../../../../core/use_cases/use_case.dart';
import '../repository/book_repository.dart';

class GetBookAllowedExtensionsUseCase extends UseCase<List<String>, void> {
  const GetBookAllowedExtensionsUseCase(this._repository);

  final BookRepository _repository;

  @override
  List<String> call([void parameter]) {
    return _repository.allowedExtensions;
  }
}
