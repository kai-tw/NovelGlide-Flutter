part of '../../backup_service.dart';

class BookBackupRepositoryOld extends BackupRepositoryOld {
  BookBackupRepositoryOld();

  @override
  Future<String> get fileName async => 'Library.zip';
}
