import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'data/data_sources/preference_local_data_source.dart';
import 'data/data_sources/preference_local_data_source_impl.dart';
import 'data/repositories/appearance_preference_repository_impl.dart';
import 'data/repositories/bookmark_list_preference_repository_impl.dart';
import 'data/repositories/bookshelf_preference_repository_impl.dart';
import 'data/repositories/locale_preference_repository_impl.dart';
import 'data/repositories/tts_preference_repository_impl.dart';
import 'domain/repositories/preference_repository.dart';

void setupPreferenceDependencies(SharedPreferences prefs) {
  // Register data sources
  sl.registerLazySingleton<PreferenceLocalDataSource>(
    () => PreferenceLocalDataSourceImpl(prefs),
  );

  // Register repositories
  sl.registerLazySingleton<AppearancePreferenceRepository>(
    () => AppearancePreferenceRepositoryImpl(sl<PreferenceLocalDataSource>()),
  );
  sl.registerLazySingleton<LocalePreferenceRepository>(
    () => LocalePreferenceRepositoryImpl(sl<PreferenceLocalDataSource>()),
  );
  sl.registerLazySingleton<TtsPreferenceRepository>(
    () => TtsPreferenceRepositoryImpl(sl<PreferenceLocalDataSource>()),
  );
  sl.registerLazySingleton<BookshelfPreferenceRepository>(
    () => BookshelfPreferenceRepositoryImpl(sl<PreferenceLocalDataSource>()),
  );
  sl.registerLazySingleton<BookmarkListPreferenceRepository>(
    () => BookmarkListPreferenceRepositoryImpl(sl<PreferenceLocalDataSource>()),
  );
}
