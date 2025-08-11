import 'dart:async';
import 'dart:io';

import '../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../bookmark/bookmark_service.dart';

part 'data/repository/backup_repository_old.dart';
part 'data/repository/book_backup_repository_old.dart';
part 'data/repository/bookmark_backup_repository_old.dart';
part 'data/repository/collection_backup_repository_old.dart';

class BackupService {
  BackupService._();

  static final BookBackupRepositoryOld bookRepository =
      BookBackupRepositoryOld();
  static final BookmarkBackupRepositoryOld bookmarkRepository =
      BookmarkBackupRepositoryOld();
  static final CollectionBackupRepository collectionRepository =
      CollectionBackupRepository();
}
