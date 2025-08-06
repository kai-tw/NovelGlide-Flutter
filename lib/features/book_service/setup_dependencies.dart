import '../../main.dart';
import 'data/data_sources/book_local_data_source.dart';
import 'data/data_sources/implementations/epub_data_source.dart';
import 'data/data_sources/implementations/pick_book_data_source_impl.dart';
import 'data/data_sources/pick_book_data_source.dart';
import 'data/repository/book_repository_impl.dart';
import 'domain/repository/book_repository.dart';
import 'domain/use_cases/add_books_use_case.dart';
import 'domain/use_cases/book_exists_use_case.dart';
import 'domain/use_cases/clear_temporary_picked_books_use_case.dart';
import 'domain/use_cases/delete_all_books_use_case.dart';
import 'domain/use_cases/delete_book_use_case.dart';
import 'domain/use_cases/get_book_allowed_extensions_use_case.dart';
import 'domain/use_cases/get_book_list_by_identifier_set_use_case.dart';
import 'domain/use_cases/get_book_list_use_case.dart';
import 'domain/use_cases/get_book_use_case.dart';
import 'domain/use_cases/observe_book_change_use_case.dart';
import 'domain/use_cases/pick_books_use_case.dart';
import 'domain/use_cases/reset_book_repository_use_case.dart';
import 'presentation/add_page/cubit/book_add_cubit.dart';
import 'presentation/bookshelf/cubit/bookshelf_cubit.dart';

void setupBookDependencies() {
  // Register data source
  sl.registerLazySingleton<BookLocalDataSource>(
    () => EpubDataSource(),
  );
  sl.registerLazySingleton<PickBookDataSource>(
    () => PickBookDataSourceImpl(),
  );

  // Register repositories
  sl.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      sl<BookLocalDataSource>(),
      sl<PickBookDataSource>(),
    ),
  );

  // Register use cases
  sl.registerLazySingleton<AddBooksUseCase>(
    () => AddBooksUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<BookExistsUseCase>(
    () => BookExistsUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<ClearTemporaryPickedBooksUseCase>(
    () => ClearTemporaryPickedBooksUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<DeleteAllBooksUseCase>(
    () => DeleteAllBooksUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<DeleteBookUseCase>(
    () => DeleteBookUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<GetBookAllowedExtensionsUseCase>(
    () => GetBookAllowedExtensionsUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<GetBookListByIdentifierSetUseCase>(
    () => GetBookListByIdentifierSetUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<GetBookListUseCase>(
    () => GetBookListUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<GetBookUseCase>(
    () => GetBookUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<ObserveBookChangeUseCase>(
    () => ObserveBookChangeUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<PickBooksUseCase>(
    () => PickBooksUseCase(sl<BookRepository>()),
  );
  sl.registerLazySingleton<ResetBookRepositoryUseCase>(
    () => ResetBookRepositoryUseCase(sl<BookRepository>()),
  );

  // Register the BookshelfCubit
  sl.registerLazySingleton(() => BookshelfCubit(
        getBookListUseCase: sl<GetBookListUseCase>(),
        deleteBookUseCase: sl<DeleteBookUseCase>(),
        observeBookChangeUseCase: sl<ObserveBookChangeUseCase>(),
        bookExistsUseCase: sl<BookExistsUseCase>(),
      ));

  // Register the BookAddCubit
  sl.registerLazySingleton<BookAddCubit>(() => BookAddCubit(
        sl<AddBooksUseCase>(),
        sl<BookExistsUseCase>(),
        sl<ClearTemporaryPickedBooksUseCase>(),
        sl<GetBookAllowedExtensionsUseCase>(),
        sl<PickBooksUseCase>(),
      ));
}
