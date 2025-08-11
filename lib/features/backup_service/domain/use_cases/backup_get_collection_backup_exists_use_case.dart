import 'dart:async';

import '../../../../core/use_cases/use_case.dart';
import '../repositories/collection_backup_repository.dart';

class BackupGetCollectionBackupExistsUseCase
    extends UseCase<Future<bool>, void> {
  BackupGetCollectionBackupExistsUseCase(this._repository);

  final CollectionBackupRepository _repository;

  @override
  Future<bool> call([void parameters]) {
    return _repository.isBackupExists();
  }
}
