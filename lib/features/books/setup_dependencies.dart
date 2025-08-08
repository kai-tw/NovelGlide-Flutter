import '../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../main.dart';
import '../collection/domain/use_cases/delete_all_books_from_collection_use_case.dart';
import 'data/data_sources/book_local_data_source.dart';
import 'data/data_sources/implementations/epub_data_source.dart';
import 'data/data_sources/implementations/pick_book_data_source_impl.dart';
import 'data/data_sources/pick_book_data_source.dart';
import 'data/repository/book_repository_impl.dart';
import 'domain/repository/book_repository.dart';
import 'domain/use_cases/book_add_use_case.dart';
import 'domain/use_cases/book_clear_temporary_picked_files_use_case.dart';
import 'domain/use_cases/book_delete_all_use_case.dart';
import 'domain/use_cases/book_delete_use_case.dart';
import 'domain/use_cases/book_exists_use_case.dart';
import 'domain/use_cases/book_get_allowed_extensions_use_case.dart';
import 'domain/use_cases/book_get_list_by_identifiers_use_case.dart';
import 'domain/use_cases/book_get_list_use_case.dart';
import 'domain/use_cases/book_get_use_case.dart';
import 'domain/use_cases/book_observe_change_use_case.dart';
import 'domain/use_cases/book_pick_use_case.dart';
import 'domain/use_cases/book_read_bytes_use_case.dart';
import 'domain/use_cases/book_reset_use_case.dart';
import 'presentation/add_page/cubit/book_add_cubit.dart';
import 'presentation/bookshelf/cubit/bookshelf_cubit.dart';

void setupBookDependencies() {
  // Register data source
  sl.registerLazySingleton<BookLocalDataSource>(
      () => EpubDataSource(sl<FileSystemRepository>()));
  sl.registerLazySingleton<PickBookDataSource>(() => PickBookDataSourceImpl());

  // Register repositories
  sl.registerLazySingleton<BookRepository>(() =>
      BookRepositoryImpl(sl<BookLocalDataSource>(), sl<PickBookDataSource>()));

  // Register use cases
  sl.registerLazySingleton<BookAddUseCase>(
      () => BookAddUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookExistsUseCase>(
      () => BookExistsUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookReadBytesUseCase>(
      () => BookReadBytesUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookClearTemporaryPickedFilesUseCase>(
      () => BookClearTemporaryPickedFilesUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookDeleteAllUseCase>(
      () => BookDeleteAllUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookDeleteUseCase>(
      () => BookDeleteUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookGetAllowedExtensionsUseCase>(
      () => BookGetAllowedExtensionsUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookGetListByIdentifiersUseCase>(
      () => BookGetListByIdentifiersUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookGetListUseCase>(
      () => BookGetListUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookGetUseCase>(
      () => BookGetUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookObserveChangeUseCase>(
      () => BookObserveChangeUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookPickUseCase>(
      () => BookPickUseCase(sl<BookRepository>()));
  sl.registerLazySingleton<BookResetUseCase>(() => BookResetUseCase(
      sl<BookRepository>(), sl<DeleteAllBooksFromCollectionUseCase>()));

  // Cubit factories
  sl.registerFactory<BookshelfCubit>(() => BookshelfCubit(
        getBookListUseCase: sl<BookGetListUseCase>(),
        deleteBookUseCase: sl<BookDeleteUseCase>(),
        observeBookChangeUseCase: sl<BookObserveChangeUseCase>(),
        bookExistsUseCase: sl<BookExistsUseCase>(),
      ));
  sl.registerFactory<BookAddCubit>(() => BookAddCubit(
        sl<BookAddUseCase>(),
        sl<BookExistsUseCase>(),
        sl<BookClearTemporaryPickedFilesUseCase>(),
        sl<BookGetAllowedExtensionsUseCase>(),
        sl<BookPickUseCase>(),
      ));
}
