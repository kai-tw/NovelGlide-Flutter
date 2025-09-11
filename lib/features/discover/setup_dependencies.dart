import '../../core/file_system/domain/repositories/json_repository.dart';
import '../../core/parser_system/domain/repository/datetime_parser.dart';
import '../../core/parser_system/domain/repository/uri_parser.dart';
import '../../core/parser_system/domain/use_cases/uri_parser_parse_https_use_case.dart';
import '../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../main.dart';
import '../books/domain/use_cases/book_download_and_add_use_case.dart';
import 'data/data_sources/explore_data_source.dart';
import 'data/data_sources/explore_favorite_data_source.dart';
import 'data/data_sources/impl/explore_json_favorite_data_source_impl.dart';
import 'data/data_sources/impl/opds_data_source_impl.dart';
import 'data/repositories/explore_favorite_repository_impl.dart';
import 'data/repositories/explore_repository_impl.dart';
import 'domain/repositories/explore_favorite_repository.dart';
import 'domain/repositories/explore_repository.dart';
import 'domain/use_cases/explore_add_to_favorite_list_use_case.dart';
import 'domain/use_cases/explore_browse_catalog_use_case.dart';
import 'domain/use_cases/explore_get_favorite_identifier_by_uri_use_case.dart';
import 'domain/use_cases/explore_get_favorite_list_use_case.dart';
import 'domain/use_cases/explore_observe_favorite_list_change_use_case.dart';
import 'domain/use_cases/explore_remove_from_favorite_list_use_case.dart';
import 'presentation/add_favorite_page/cubits/explore_add_favorite_page_cubit.dart';
import 'presentation/browser/cubits/explore_browser_cubit.dart';
import 'presentation/favorite_list/cubit/explore_favorite_list_cubit.dart';

/// Setup the dependencies of discovery system
void setupDiscoverDependencies() {
  // Register data sources
  sl.registerLazySingleton<ExploreDataSource>(
    () => OpdsDataSourceImpl(
      sl<DateTimeParser>(),
      sl<UriParser>(),
    ),
  );
  sl.registerLazySingleton<ExploreFavoriteDataSource>(
    () => ExploreJsonFavoriteDataSourceImpl(
      sl<JsonPathProvider>(),
      sl<JsonRepository>(),
    ),
  );

  // Register repositories
  sl.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(
      sl<ExploreDataSource>(),
    ),
  );
  sl.registerLazySingleton<ExploreFavoriteRepository>(
    () => ExploreFavoriteRepositoryImpl(
      sl<ExploreFavoriteDataSource>(),
    ),
  );

  // Register browser use cases
  sl.registerFactory<ExploreBrowseCatalogUseCase>(
    () => ExploreBrowseCatalogUseCase(
      sl<ExploreRepository>(),
    ),
  );

  // Register favorite use cases
  sl.registerFactory<DiscoverAddToFavoriteListUseCase>(
    () => DiscoverAddToFavoriteListUseCase(
      sl<ExploreFavoriteRepository>(),
    ),
  );
  sl.registerFactory<ExploreGetFavoriteListUseCase>(
    () => ExploreGetFavoriteListUseCase(
      sl<ExploreFavoriteRepository>(),
    ),
  );
  sl.registerFactory<ExploreGetFavoriteIdentifierByUriUseCase>(
    () => ExploreGetFavoriteIdentifierByUriUseCase(
      sl<ExploreFavoriteRepository>(),
    ),
  );
  sl.registerFactory<ExploreObserveFavoriteListChangeUseCase>(
    () => ExploreObserveFavoriteListChangeUseCase(
      sl<ExploreFavoriteRepository>(),
    ),
  );
  sl.registerFactory<ExploreRemoveFromFavoriteListUseCase>(
    () => ExploreRemoveFromFavoriteListUseCase(
      sl<ExploreFavoriteRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<ExploreBrowserCubit>(
    () => ExploreBrowserCubit(
      sl<ExploreBrowseCatalogUseCase>(),
      sl<ExploreGetFavoriteIdentifierByUriUseCase>(),
      sl<ExploreRemoveFromFavoriteListUseCase>(),
      sl<DiscoverAddToFavoriteListUseCase>(),
      sl<UriParserParseHttpsUseCase>(),
      sl<BookDownloadAndAddUseCase>(),
    ),
  );
  sl.registerFactory<ExploreFavoriteListCubit>(
    () => ExploreFavoriteListCubit(
      sl<ExploreGetFavoriteListUseCase>(),
      sl<ExploreObserveFavoriteListChangeUseCase>(),
    ),
  );
  sl.registerFactory<ExploreAddFavoritePageCubit>(
    () => ExploreAddFavoritePageCubit(
      sl<DiscoverAddToFavoriteListUseCase>(),
      sl<UriParserParseHttpsUseCase>(),
    ),
  );
}
