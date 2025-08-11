import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/file_system/domain/repositories/temp_repository.dart';
import '../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../main.dart';
import '../books/domain/repository/book_repository.dart';
import 'data/repositories/book_backup_repository_impl.dart';
import 'domain/repositories/book_backup_repository.dart';
import 'domain/use_cases/backup_book_create_use_case.dart';
import 'domain/use_cases/backup_book_delete_use_case.dart';
import 'domain/use_cases/backup_book_restore_use_case.dart';
import 'presentation/process_dialog/cubit/item_cubits/backup_service_process_library_cubit.dart';

void setupBackupDependencies() {
  // Register repositories
  sl.registerLazySingleton<BookBackupRepository>(() => BookBackupRepositoryImpl(
        sl<AppPathProvider>(),
        sl<FileSystemRepository>(),
        sl<BookRepository>(),
      ));

  // Register use cases
  sl.registerFactory<BackupBookCreateUseCase>(() => BackupBookCreateUseCase(
        sl<FileSystemRepository>(),
        sl<TempRepository>(),
        sl<BookBackupRepository>(),
      ));
  sl.registerFactory<BackupBookRestoreUseCase>(() => BackupBookRestoreUseCase(
        sl<FileSystemRepository>(),
        sl<TempRepository>(),
        sl<BookBackupRepository>(),
      ));
  sl.registerFactory<BackupBookDeleteUseCase>(() => BackupBookDeleteUseCase(
        sl<BookBackupRepository>(),
      ));

  // Register cubits
  sl.registerFactory<BackupServiceProcessLibraryCubit>(
      () => BackupServiceProcessLibraryCubit(
            sl<BackupBookCreateUseCase>(),
            sl<BackupBookRestoreUseCase>(),
            sl<BackupBookDeleteUseCase>(),
          ));
}
