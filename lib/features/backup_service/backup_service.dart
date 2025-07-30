import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../core/interfaces/google_api_interfaces/google_api_interfaces.dart';
import '../../core/services/file_system_service/file_system_service.dart';
import '../../core/services/log_service/log_service.dart';
import '../book_service/book_service.dart';
import '../bookmark_service/bookmark_service.dart';
import '../collection_service/collection_service.dart';

part 'data/model/backup_progress_step_code.dart';
part 'data/model/backup_target_type.dart';
part 'data/model/backup_task_type.dart';
part 'data/repository/backup_repository.dart';
part 'data/repository/book_backup_repository.dart';
part 'data/repository/bookmark_backup_repository.dart';
part 'data/repository/collection_backup_repository.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_bookmark_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_collection_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_item_cubit.dart';
part 'presentation/process_dialog/cubit/item_cubits/backup_service_process_library_cubit.dart';
part 'presentation/process_dialog/cubit/states/backup_service_process_item_state.dart';

class BackupService {
  BackupService._();

  static final BookBackupRepository bookRepository = BookBackupRepository();
  static final BookmarkBackupRepository bookmarkRepository =
      BookmarkBackupRepository();
  static final CollectionBackupRepository collectionRepository =
      CollectionBackupRepository();
}
