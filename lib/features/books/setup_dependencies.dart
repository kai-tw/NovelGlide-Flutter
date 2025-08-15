import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../core/mime_resolver/domain/repositories/mime_repository.dart';
import '../../core/path_provider/domain/repositories/app_path_provider.dart';
import '../../main.dart';
import '../bookmark/domain/use_cases/bookmark_get_data_use_case.dart';
import '../bookmark/domain/use_cases/bookmark_observe_change_use_case.dart';
import '../bookmark/domain/use_cases/bookmark_reset_use_case.dart';
import '../collection/domain/use_cases/collection_delete_all_books_use_case.dart';
import '../pick_file/domain/repositories/pick_file_repository.dart';
import '../preference/domain/repositories/preference_repository.dart';
import '../preference/domain/use_cases/preference_get_use_cases.dart';
import '../reader/domain/use_cases/reader_clear_location_cache_use_case.dart';
import '../reader/domain/use_cases/reader_delete_location_cache_use_case.dart';
import 'data/data_sources/book_local_data_source.dart';
import 'data/data_sources/implementations/epub_data_source.dart';
import 'data/repositories/book_repository_impl.dart';
import 'domain/repositories/book_repository.dart';
import 'domain/use_cases/book_add_use_case.dart';
import 'domain/use_cases/book_clear_temporary_picked_files_use_case.dart';
import 'domain/use_cases/book_delete_use_case.dart';
import 'domain/use_cases/book_exists_use_case.dart';
import 'domain/use_cases/book_get_allowed_extensions_use_case.dart';
import 'domain/use_cases/book_get_chapter_list_use_case.dart';
import 'domain/use_cases/book_get_cover_use_case.dart';
import 'domain/use_cases/book_get_list_by_identifiers_use_case.dart';
import 'domain/use_cases/book_get_list_use_case.dart';
import 'domain/use_cases/book_get_use_case.dart';
import 'domain/use_cases/book_is_file_valid_use_case.dart';
import 'domain/use_cases/book_observe_change_use_case.dart';
import 'domain/use_cases/book_pick_use_case.dart';
import 'domain/use_cases/book_read_bytes_use_case.dart';
import 'domain/use_cases/book_reset_use_case.dart';
import 'presentation/add_page/cubit/book_add_cubit.dart';
import 'presentation/bookshelf/cubit/bookshelf_cubit.dart';
import 'presentation/table_of_contents_page/cubit/toc_cubit.dart';

void setupBookDependencies() {
  /// Register data source
  sl.registerLazySingleton<BookLocalDataSource>(() => EpubDataSource(
        sl<AppPathProvider>(),
        sl<FileSystemRepository>(),
        sl<MimeRepository>(),
      ));

  /// Register repositories
  sl.registerLazySingleton<BookRepository>(() => BookRepositoryImpl(
        sl<BookLocalDataSource>(),
        sl<FileSystemRepository>(),
        sl<PickFileRepository>(),
      ));

  /// Register book management use cases
  sl.registerFactory<BookAddUseCase>(
      () => BookAddUseCase(sl<BookRepository>()));
  sl.registerFactory<BookExistsUseCase>(
      () => BookExistsUseCase(sl<BookRepository>()));
  sl.registerFactory<BookReadBytesUseCase>(
      () => BookReadBytesUseCase(sl<BookRepository>()));
  sl.registerFactory<BookClearTemporaryPickedFilesUseCase>(
      () => BookClearTemporaryPickedFilesUseCase(sl<BookRepository>()));
  sl.registerFactory<BookDeleteUseCase>(() => BookDeleteUseCase(
        sl<BookRepository>(),
        sl<ReaderDeleteLocationCacheUseCase>(),
      ));
  sl.registerFactory<BookGetAllowedExtensionsUseCase>(
      () => BookGetAllowedExtensionsUseCase(sl<BookRepository>()));
  sl.registerFactory<BookGetListByIdentifiersUseCase>(
      () => BookGetListByIdentifiersUseCase(sl<BookRepository>()));
  sl.registerFactory<BookGetListUseCase>(
      () => BookGetListUseCase(sl<BookRepository>()));
  sl.registerFactory<BookGetUseCase>(
      () => BookGetUseCase(sl<BookRepository>()));
  sl.registerFactory<BookIsFileValidUseCase>(
      () => BookIsFileValidUseCase(sl<BookRepository>()));
  sl.registerFactory<BookObserveChangeUseCase>(
      () => BookObserveChangeUseCase(sl<BookRepository>()));
  sl.registerFactory<BookPickUseCase>(
      () => BookPickUseCase(sl<BookRepository>()));
  sl.registerFactory<BookGetCoverUseCase>(
      () => BookGetCoverUseCase(sl<BookRepository>()));
  sl.registerFactory<BookGetChapterListUseCase>(
      () => BookGetChapterListUseCase(sl<BookRepository>()));
  sl.registerFactory<BookResetUseCase>(() => BookResetUseCase(
        sl<BookRepository>(),
        sl<BookmarkResetUseCase>(),
        sl<CollectionDeleteAllBooksUseCase>(),
        sl<ReaderClearLocationCacheUseCase>(),
      ));

  /// Register bookshelf preference use cases
  sl.registerFactory<BookshelfGetPreferenceUseCase>(
      () => BookshelfGetPreferenceUseCase(
            sl<BookshelfPreferenceRepository>(),
          ));

  /// Cubit factories
  sl.registerFactory<BookshelfCubit>(() => BookshelfCubit(
        // Book managements use cases
        sl<BookGetListUseCase>(),
        sl<BookDeleteUseCase>(),
        sl<BookObserveChangeUseCase>(),
        sl<BookExistsUseCase>(),
        sl<BookGetCoverUseCase>(),
        // Bookshelf preferences use cases
        sl<BookshelfGetPreferenceUseCase>(),
      ));
  sl.registerFactory<BookAddCubit>(() => BookAddCubit(
        sl<BookAddUseCase>(),
        sl<BookClearTemporaryPickedFilesUseCase>(),
        sl<BookGetAllowedExtensionsUseCase>(),
        sl<BookPickUseCase>(),
      ));
  sl.registerFactory<TocCubit>(() => TocCubit(
        sl<BookGetChapterListUseCase>(),
        sl<BookmarkGetDataUseCase>(),
        sl<BookmarkObserveChangeUseCase>(),
      ));
}
