import '../../core/file_system/domain/repositories/json_repository.dart';
import '../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../main.dart';
import '../books/domain/use_cases/get_book_list_by_identifier_set_use_case.dart';
import 'collection_service.dart';
import 'data/data_sources/collection_local_json_data_source.dart';
import 'data/data_sources/impl/collection_local_json_data_source_impl.dart';
import 'data/repositories/collection_repository_impl.dart';
import 'domain/repositories/collection_repository.dart';
import 'domain/use_cases/create_collection_data_use_case.dart';
import 'domain/use_cases/delete_all_books_from_collection_use_case.dart';
import 'domain/use_cases/delete_collection_data_use_case.dart';
import 'domain/use_cases/get_collection_data_by_id_use_case.dart';
import 'domain/use_cases/get_collection_list_use_case.dart';
import 'domain/use_cases/observe_collection_change_use_case.dart';
import 'domain/use_cases/reset_collection_system_use_case.dart';
import 'domain/use_cases/update_collection_data_use_case.dart';
import 'presentation/collection_list/cubit/collection_list_cubit.dart';
import 'presentation/collection_viewer/cubit/collection_viewer_cubit.dart';

void setupCollectionDependencies() {
  // Register data sources
  sl.registerLazySingleton<CollectionLocalJsonDataSource>(
      () => CollectionLocalJsonDataSourceImpl(
            sl<JsonPathProvider>(),
            sl<JsonRepository>(),
          ));

  // Register repository
  sl.registerLazySingleton<CollectionRepository>(
      () => CollectionRepositoryImpl(sl<CollectionLocalJsonDataSource>()));

  // Register use cases
  sl.registerLazySingleton<CreateCollectionDataUseCase>(
      () => CreateCollectionDataUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<DeleteAllBooksFromCollectionUseCase>(
      () => DeleteAllBooksFromCollectionUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<DeleteCollectionDataUseCase>(
      () => DeleteCollectionDataUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<GetCollectionDataByIdUseCase>(
      () => GetCollectionDataByIdUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<GetCollectionListUseCase>(
      () => GetCollectionListUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<ObserveCollectionChangeUseCase>(
      () => ObserveCollectionChangeUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<ResetCollectionSystemUseCase>(
      () => ResetCollectionSystemUseCase(sl<CollectionRepository>()));
  sl.registerLazySingleton<UpdateCollectionDataUseCase>(
      () => UpdateCollectionDataUseCase(sl<CollectionRepository>()));

  // Cubit factories
  sl.registerFactory<CollectionViewerCubit>(() => CollectionViewerCubit(
        sl<GetBookListByIdentifierSetUseCase>(),
        sl<GetCollectionDataByIdUseCase>(),
        sl<UpdateCollectionDataUseCase>(),
      ));
  sl.registerFactory<CollectionListCubit>(() => CollectionListCubit(
        sl<DeleteCollectionDataUseCase>(),
        sl<GetCollectionListUseCase>(),
        sl<ObserveCollectionChangeUseCase>(),
      ));
  sl.registerFactory<CollectionAddBookCubit>(() => CollectionAddBookCubit(
        sl<GetCollectionListUseCase>(),
        sl<ObserveCollectionChangeUseCase>(),
        sl<UpdateCollectionDataUseCase>(),
      ));
  sl.registerFactory<CollectionAddCubit>(() => CollectionAddCubit(
        sl<CreateCollectionDataUseCase>(),
      ));
}
