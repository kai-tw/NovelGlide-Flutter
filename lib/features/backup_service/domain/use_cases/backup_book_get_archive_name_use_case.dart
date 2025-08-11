import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_backup_repository.dart';

class BackupBookGetArchiveNameUseCase extends UseCase<Future<String>, void> {
  BackupBookGetArchiveNameUseCase(this._repository);

  final BookBackupRepository _repository;

  @override
  Future<String> call([void parameter]) {
    return _repository.archiveName;
  }
}
