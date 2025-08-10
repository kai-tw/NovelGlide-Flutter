import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../main.dart';
import '../bookmark/domain/use_cases/bookmark_get_data_use_case.dart';
import '../bookmark/domain/use_cases/bookmark_update_data_use_case.dart';
import '../books/domain/use_cases/book_get_use_case.dart';
import '../books/domain/use_cases/book_read_bytes_use_case.dart';
import 'data/repositories/reader_location_cache_repository_impl.dart';
import 'domain/repositories/reader_location_cache_repository.dart';
import 'domain/use_cases/reader_clear_location_cache_use_case.dart';
import 'domain/use_cases/reader_delete_location_cache_use_case.dart';
import 'domain/use_cases/reader_get_location_cache_use_case.dart';
import 'domain/use_cases/reader_store_location_cache_use_case.dart';
import 'presentation/reader_page/cubit/reader_cubit.dart';

void setupReaderDependencies() {
  // Register repositories
  sl.registerLazySingleton<ReaderLocationCacheRepository>(
      () => ReaderLocationCacheRepositoryImpl(
            sl<AppPathProvider>(),
            sl<FileSystemRepository>(),
          ));

  // Register use cases
  sl.registerFactory<ReaderClearLocationCacheUseCase>(
      () => ReaderClearLocationCacheUseCase(
            sl<ReaderLocationCacheRepository>(),
          ));
  sl.registerFactory<ReaderDeleteLocationCacheUseCase>(
      () => ReaderDeleteLocationCacheUseCase(
            sl<ReaderLocationCacheRepository>(),
          ));
  sl.registerFactory<ReaderGetLocationCacheUseCase>(
      () => ReaderGetLocationCacheUseCase(
            sl<ReaderLocationCacheRepository>(),
          ));
  sl.registerFactory<ReaderStoreLocationCacheUseCase>(
      () => ReaderStoreLocationCacheUseCase(
            sl<ReaderLocationCacheRepository>(),
          ));

  // Register factories
  sl.registerFactory<ReaderCubit>(() => ReaderCubit(
        // Book use cases
        sl<BookReadBytesUseCase>(),
        sl<BookGetUseCase>(),
        // Location cache use cases
        sl<ReaderStoreLocationCacheUseCase>(),
        sl<ReaderGetLocationCacheUseCase>(),
        // Bookmark use cases
        sl<BookmarkGetDataUseCase>(),
        sl<BookmarkUpdateDataUseCase>(),
      ));
}
