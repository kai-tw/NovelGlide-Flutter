part of '../../backup_service.dart';

class BookmarkBackupRepositoryOld extends BackupRepositoryOld {
  BookmarkBackupRepositoryOld();

  @override
  Future<String> get fileName => BookmarkService.repository.jsonFileName;
}
