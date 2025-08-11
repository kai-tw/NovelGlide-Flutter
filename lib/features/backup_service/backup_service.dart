import 'dart:async';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path/path.dart';

import '../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../core/log_system/log_system.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../bookmark/bookmark_service.dart';
import '../bookmark/domain/entities/bookmark_data.dart';
import '../books/book_service.dart';
import '../collection/collection_service.dart';
import '../collection/domain/entities/collection_data.dart';

part 'data/repository/backup_repository_old.dart';
part 'data/repository/book_backup_repository.dart';
part 'data/repository/bookmark_backup_repository.dart';
part 'data/repository/collection_backup_repository.dart';

class BackupService {
  BackupService._();

  static final BookBackupRepository bookRepository = BookBackupRepository();
  static final BookmarkBackupRepository bookmarkRepository =
      BookmarkBackupRepository();
  static final CollectionBackupRepository collectionRepository =
      CollectionBackupRepository();
}
