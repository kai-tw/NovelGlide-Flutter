import '../../core/file_system/domain/repositories/json_repository.dart';
import '../../core/parser_system/domain/repository/datetime_parser.dart';
import '../../core/parser_system/domain/repository/uri_parser.dart';
import '../../core/parser_system/domain/use_cases/uri_parser_parse_https_use_case.dart';
import '../../core/path_provider/domain/repositories/json_path_provider.dart';
import '../../main.dart';
import '../books/domain/use_cases/book_download_and_add_use_case.dart';
import 'data/data_sources/discover_data_source.dart';
import 'data/data_sources/discover_favorite_data_source.dart';
import 'data/data_sources/impl/discover_json_favorite_data_source_impl.dart';
import 'data/data_sources/impl/opds_data_source_impl.dart';
import 'data/repositories/discover_favorite_repository_impl.dart';
import 'data/repositories/discover_repository_impl.dart';
import 'domain/repositories/discover_favorite_repository.dart';
import 'domain/repositories/discover_repository.dart';
import 'domain/use_cases/discover_add_to_favorite_list_use_case.dart';
import 'domain/use_cases/discover_browse_catalog_use_case.dart';
import 'domain/use_cases/discover_get_favorite_identifier_by_uri_use_case.dart';
import 'domain/use_cases/discover_get_favorite_list_use_case.dart';
import 'domain/use_cases/discover_observe_favorite_list_change_use_case.dart';
import 'domain/use_cases/discover_remove_from_favorite_list_use_case.dart';
import 'domain/use_cases/discover_search_catalog_use_case.dart';
import 'presentation/add_favorite_page/cubits/discover_add_favorite_page_cubit.dart';
import 'presentation/browser/cubits/discover_browser_cubit.dart';
import 'presentation/favorite_list/cubit/discover_favorite_list_cubit.dart';

/// Setup the dependencies of discovery system
void setupDiscoverDependencies() {
  // Register data sources
  sl.registerLazySingleton<DiscoverDataSource>(
    () => OpdsDataSourceImpl(
      sl<DateTimeParser>(),
      sl<UriParser>(),
    ),
  );
  sl.registerLazySingleton<DiscoverFavoriteDataSource>(
    () => DiscoverJsonFavoriteDataSourceImpl(
      sl<JsonPathProvider>(),
      sl<JsonRepository>(),
    ),
  );

  // Register repositories
  sl.registerLazySingleton<DiscoverRepository>(
    () => DiscoverRepositoryImpl(
      sl<DiscoverDataSource>(),
    ),
  );
  sl.registerLazySingleton<DiscoverFavoriteRepository>(
    () => DiscoverFavoriteRepositoryImpl(
      sl<DiscoverFavoriteDataSource>(),
    ),
  );

  // Register browser use cases
  sl.registerFactory<DiscoverBrowseCatalogUseCase>(
    () => DiscoverBrowseCatalogUseCase(
      sl<DiscoverRepository>(),
    ),
  );
  sl.registerFactory<DiscoverSearchCatalogUseCase>(
    () => DiscoverSearchCatalogUseCase(
      sl<DiscoverRepository>(),
    ),
  );

  // Register favorite use cases
  sl.registerFactory<DiscoverAddToFavoriteListUseCase>(
    () => DiscoverAddToFavoriteListUseCase(
      sl<DiscoverFavoriteRepository>(),
    ),
  );
  sl.registerFactory<DiscoverGetFavoriteListUseCase>(
    () => DiscoverGetFavoriteListUseCase(
      sl<DiscoverFavoriteRepository>(),
    ),
  );
  sl.registerFactory<DiscoverGetFavoriteIdentifierByUriUseCase>(
    () => DiscoverGetFavoriteIdentifierByUriUseCase(
      sl<DiscoverFavoriteRepository>(),
    ),
  );
  sl.registerFactory<DiscoverObserveFavoriteListChangeUseCase>(
    () => DiscoverObserveFavoriteListChangeUseCase(
      sl<DiscoverFavoriteRepository>(),
    ),
  );
  sl.registerFactory<DiscoverRemoveFromFavoriteListUseCase>(
    () => DiscoverRemoveFromFavoriteListUseCase(
      sl<DiscoverFavoriteRepository>(),
    ),
  );

  // Register cubits
  sl.registerFactory<DiscoverBrowserCubit>(
    () => DiscoverBrowserCubit(
      sl<DiscoverBrowseCatalogUseCase>(),
      sl<DiscoverGetFavoriteIdentifierByUriUseCase>(),
      sl<DiscoverRemoveFromFavoriteListUseCase>(),
      sl<DiscoverAddToFavoriteListUseCase>(),
      sl<UriParserParseHttpsUseCase>(),
      sl<BookDownloadAndAddUseCase>(),
    ),
  );
  sl.registerFactory<DiscoverFavoriteListCubit>(
    () => DiscoverFavoriteListCubit(
      sl<DiscoverGetFavoriteListUseCase>(),
      sl<DiscoverObserveFavoriteListChangeUseCase>(),
    ),
  );
  sl.registerFactory<DiscoverAddFavoritePageCubit>(
    () => DiscoverAddFavoritePageCubit(
      sl<DiscoverAddToFavoriteListUseCase>(),
      sl<UriParserParseHttpsUseCase>(),
    ),
  );
}
