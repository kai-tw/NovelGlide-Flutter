import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/file_system/domain/repositories/json_repository.dart';
import '../../core/file_system/domain/repositories/temp_repository.dart';
import '../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../main.dart';
import '../auth/domain/use_cases/auth_is_sign_in_use_case.dart';
import '../auth/domain/use_cases/auth_sign_in_use_case.dart';
import '../auth/domain/use_cases/auth_sign_out_use_case.dart';
import '../bookmark/domain/repositories/bookmark_repository.dart';
import '../books/domain/repositories/book_repository.dart';
import '../cloud/domain/repositories/cloud_repository.dart';
import '../collection/domain/repositories/collection_repository.dart';
import '../preference/domain/repositories/preference_repository.dart';
import '../preference/domain/use_cases/preference_get_use_cases.dart';
import '../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../preference/domain/use_cases/preference_save_use_case.dart';
import 'data/repositories/book_backup_repository_impl.dart';
import 'data/repositories/bookmark_backup_repository_impl.dart';
import 'data/repositories/collection_backup_repository_impl.dart';
import 'domain/repositories/book_backup_repository.dart';
import 'domain/repositories/bookmark_backup_repository.dart';
import 'domain/repositories/collection_backup_repository.dart';
import 'domain/use_cases/backup_book_create_use_case.dart';
import 'domain/use_cases/backup_book_delete_use_case.dart';
import 'domain/use_cases/backup_book_restore_use_case.dart';
import 'domain/use_cases/backup_bookmark_create_use_case.dart';
import 'domain/use_cases/backup_bookmark_delete_use_case.dart';
import 'domain/use_cases/backup_bookmark_restore_use_case.dart';
import 'domain/use_cases/backup_collection_create_use_case.dart';
import 'domain/use_cases/backup_collection_delete_use_case.dart';
import 'domain/use_cases/backup_collection_restore_use_case.dart';
import 'domain/use_cases/backup_get_book_backup_exists_use_case.dart';
import 'domain/use_cases/backup_get_bookmark_backup_exists_use_case.dart';
import 'domain/use_cases/backup_get_collection_backup_exists_use_case.dart';
import 'domain/use_cases/backup_get_last_backup_time_use_case.dart';
import 'presentation/google_drive/cubit/backup_service_google_drive_cubit.dart';
import 'presentation/process_dialog/cubit/item_cubits/backup_service_process_bookmark_cubit.dart';
import 'presentation/process_dialog/cubit/item_cubits/backup_service_process_collection_cubit.dart';
import 'presentation/process_dialog/cubit/item_cubits/backup_service_process_library_cubit.dart';

void setupBackupDependencies() {
  // Register repositories
  sl.registerLazySingleton<BookBackupRepository>(
    () => BookBackupRepositoryImpl(
      sl<AppPathProvider>(),
      sl<FileSystemRepository>(),
      sl<BookRepository>(),
      sl<CloudRepository>(),
    ),
  );
  sl.registerLazySingleton<BookmarkBackupRepository>(
    () => BookmarkBackupRepositoryImpl(
      sl<JsonPathProvider>(),
      sl<FileSystemRepository>(),
      sl<CloudRepository>(),
    ),
  );
  sl.registerLazySingleton<CollectionBackupRepository>(
    () => CollectionBackupRepositoryImpl(
      sl<JsonPathProvider>(),
      sl<FileSystemRepository>(),
      sl<CloudRepository>(),
    ),
  );

  // Register use cases
  sl.registerFactory<BackupBookCreateUseCase>(
    () => BackupBookCreateUseCase(
      sl<FileSystemRepository>(),
      sl<TempRepository>(),
      sl<BookBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupBookRestoreUseCase>(
    () => BackupBookRestoreUseCase(
      sl<FileSystemRepository>(),
      sl<TempRepository>(),
      sl<BookBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupBookDeleteUseCase>(
    () => BackupBookDeleteUseCase(
      sl<BookBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupBookmarkCreateUseCase>(
    () => BackupBookmarkCreateUseCase(
      sl<BookmarkBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupBookmarkRestoreUseCase>(
    () => BackupBookmarkRestoreUseCase(
      sl<BookmarkBackupRepository>(),
      sl<FileSystemRepository>(),
      sl<JsonRepository>(),
      sl<TempRepository>(),
      sl<BookmarkRepository>(),
    ),
  );
  sl.registerFactory<BackupBookmarkDeleteUseCase>(
    () => BackupBookmarkDeleteUseCase(
      sl<BookmarkBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupCollectionCreateUseCase>(
    () => BackupCollectionCreateUseCase(
      sl<CollectionBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupCollectionRestoreUseCase>(
    () => BackupCollectionRestoreUseCase(
      sl<CollectionBackupRepository>(),
      sl<FileSystemRepository>(),
      sl<JsonRepository>(),
      sl<TempRepository>(),
      sl<CollectionRepository>(),
    ),
  );
  sl.registerFactory<BackupCollectionDeleteUseCase>(
    () => BackupCollectionDeleteUseCase(
      sl<CollectionBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupGetLastBackupTimeUseCase>(
    () => BackupGetLastBackupTimeUseCase(
      sl<BookBackupRepository>(),
      sl<BookmarkBackupRepository>(),
      sl<CollectionBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupGetBookBackupExistsUseCase>(
    () => BackupGetBookBackupExistsUseCase(
      sl<BookBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupGetBookmarkBackupExistsUseCase>(
    () => BackupGetBookmarkBackupExistsUseCase(
      sl<BookmarkBackupRepository>(),
    ),
  );
  sl.registerFactory<BackupGetCollectionBackupExistsUseCase>(
    () => BackupGetCollectionBackupExistsUseCase(
      sl<CollectionBackupRepository>(),
    ),
  );

  // Register preferences use cases
  sl.registerFactory<BackupGetPreferenceUseCase>(
    () => BackupGetPreferenceUseCase(
      sl<BackupPreferenceRepository>(),
    ),
  );
  sl.registerFactory<BackupSavePreferenceUseCase>(
    () => BackupSavePreferenceUseCase(
      sl<BackupPreferenceRepository>(),
    ),
  );
  sl.registerFactory<BackupObservePreferenceChangeUseCase>(
    () => BackupObservePreferenceChangeUseCase(
      sl<BackupPreferenceRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<BackupServiceProcessLibraryCubit>(
    () => BackupServiceProcessLibraryCubit(
      sl<BackupBookCreateUseCase>(),
      sl<BackupBookRestoreUseCase>(),
      sl<BackupBookDeleteUseCase>(),
    ),
  );
  sl.registerFactory<BackupServiceProcessBookmarkCubit>(
    () => BackupServiceProcessBookmarkCubit(
      sl<BackupBookmarkCreateUseCase>(),
      sl<BackupBookmarkRestoreUseCase>(),
      sl<BackupBookmarkDeleteUseCase>(),
    ),
  );
  sl.registerFactory<BackupServiceProcessCollectionCubit>(
    () => BackupServiceProcessCollectionCubit(
      sl<BackupCollectionCreateUseCase>(),
      sl<BackupCollectionRestoreUseCase>(),
      sl<BackupCollectionDeleteUseCase>(),
    ),
  );
  sl.registerFactory<BackupServiceGoogleDriveCubit>(
    () => BackupServiceGoogleDriveCubit(
      sl<BackupGetBookBackupExistsUseCase>(),
      sl<BackupGetBookmarkBackupExistsUseCase>(),
      sl<BackupGetCollectionBackupExistsUseCase>(),
      sl<BackupGetLastBackupTimeUseCase>(),
      sl<AuthIsSignInUseCase>(),
      sl<AuthSignInUseCase>(),
      sl<AuthSignOutUseCase>(),
      sl<BackupGetPreferenceUseCase>(),
      sl<BackupSavePreferenceUseCase>(),
      sl<BackupObservePreferenceChangeUseCase>(),
    ),
  );
}
