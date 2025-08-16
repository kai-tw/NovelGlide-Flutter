import '../../core/file_system/domain/repositories/json_repository.dart';
import '../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../main.dart';
import '../books/domain/repositories/book_repository.dart';
import '../preference/domain/repositories/preference_repository.dart';
import '../preference/domain/use_cases/preference_get_use_cases.dart';
import '../preference/domain/use_cases/preference_observe_change_use_case.dart';
import '../preference/domain/use_cases/preference_reset_use_case.dart';
import '../preference/domain/use_cases/preference_save_use_case.dart';
import 'data/data_sources/bookmark_local_json_data_source.dart';
import 'data/data_sources/bookmark_local_json_data_source_impl.dart';
import 'data/repositories/bookmark_repository_impl.dart';
import 'domain/repositories/bookmark_repository.dart';
import 'domain/use_cases/bookmark_delete_data_use_case.dart';
import 'domain/use_cases/bookmark_get_data_use_case.dart';
import 'domain/use_cases/bookmark_get_list_use_case.dart';
import 'domain/use_cases/bookmark_observe_change_use_case.dart';
import 'domain/use_cases/bookmark_reset_use_case.dart';
import 'domain/use_cases/bookmark_update_data_use_case.dart';
import 'presentation/bookmark_list/cubit/bookmark_list_cubit.dart';

void setupBookmarkDependencies() {
  // Register data sources
  sl.registerLazySingleton<BookmarkLocalJsonDataSource>(
      () => BookmarkLocalJsonDataSourceImpl(
            sl<JsonPathProvider>(),
            sl<JsonRepository>(),
          ));

  // Register repositories
  sl.registerLazySingleton<BookmarkRepository>(() => BookmarkRepositoryImpl(
        sl<BookmarkLocalJsonDataSource>(),
        sl<BookRepository>(),
      ));

  // Register bookmark use cases
  sl.registerFactory<BookmarkDeleteDataUseCase>(() => BookmarkDeleteDataUseCase(
        sl<BookmarkRepository>(),
      ));
  sl.registerFactory<BookmarkGetDataUseCase>(() => BookmarkGetDataUseCase(
        sl<BookmarkRepository>(),
      ));
  sl.registerFactory<BookmarkGetListUseCase>(() => BookmarkGetListUseCase(
        sl<BookmarkRepository>(),
      ));
  sl.registerFactory<BookmarkObserveChangeUseCase>(
      () => BookmarkObserveChangeUseCase(
            sl<BookmarkRepository>(),
          ));
  sl.registerFactory<BookmarkResetUseCase>(() => BookmarkResetUseCase(
        sl<BookmarkRepository>(),
      ));
  sl.registerFactory<BookmarkUpdateDataUseCase>(() => BookmarkUpdateDataUseCase(
        sl<BookmarkRepository>(),
      ));

  // Register bookmark list use cases
  sl.registerFactory<BookmarkListGetPreferenceUseCase>(
    () => BookmarkListGetPreferenceUseCase(
      sl<BookmarkListPreferenceRepository>(),
    ),
  );
  sl.registerFactory<BookmarkListSavePreferenceUseCase>(
    () => BookmarkListSavePreferenceUseCase(
      sl<BookmarkListPreferenceRepository>(),
    ),
  );
  sl.registerFactory<BookmarkListResetPreferenceUseCase>(
    () => BookmarkListResetPreferenceUseCase(
      sl<BookmarkListPreferenceRepository>(),
    ),
  );
  sl.registerFactory<BookmarkListObserveChangeUseCase>(
    () => BookmarkListObserveChangeUseCase(
      sl<BookmarkListPreferenceRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<BookmarkListCubit>(() => BookmarkListCubit(
        sl<BookmarkGetListUseCase>(),
        sl<BookmarkDeleteDataUseCase>(),
        sl<BookmarkObserveChangeUseCase>(),
        sl<BookmarkListGetPreferenceUseCase>(),
        sl<BookmarkListSavePreferenceUseCase>(),
        sl<BookmarkListObserveChangeUseCase>(),
      ));
}
