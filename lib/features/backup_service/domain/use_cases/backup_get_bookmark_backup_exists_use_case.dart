import 'dart:async';

import '../../../../core/use_cases/use_case.dart';
import '../repositories/bookmark_backup_repository.dart';

class BackupGetBookmarkBackupExistsUseCase extends UseCase<Future<bool>, void> {
  BackupGetBookmarkBackupExistsUseCase(this._repository);

  final BookmarkBackupRepository _repository;

  @override
  Future<bool> call([void parameters]) {
    return _repository.isBackupExists();
  }
}
