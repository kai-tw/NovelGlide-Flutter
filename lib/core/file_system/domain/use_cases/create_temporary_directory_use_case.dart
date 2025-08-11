import '../../../use_cases/use_case.dart';
import '../repositories/temp_repository.dart';

class CreateTemporaryDirectoryUseCase extends UseCase<Future<String>, void> {
  const CreateTemporaryDirectoryUseCase(this._repository);

  final TempRepository _repository;

  @override
  Future<String> call([void parameter]) {
    return _repository.getDirectoryPath();
  }
}
