import 'dart:async';

import '../../../../core/use_cases/use_case.dart';
import '../repositories/book_backup_repository.dart';

class BackupGetBookBackupExistsUseCase extends UseCase<Future<bool>, void> {
  BackupGetBookBackupExistsUseCase(this._repository);

  final BookBackupRepository _repository;

  @override
  Future<bool> call([void parameters]) {
    return _repository.isBackupExists();
  }
}
