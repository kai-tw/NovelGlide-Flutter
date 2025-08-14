import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'data/repositories/preference_repository_impl.dart';
import 'domain/repositories/preference_repository.dart';

void setupPreferenceDependencies(SharedPreferences prefs) {
  // Register repositories
  sl.registerLazySingleton<PreferenceRepository>(
    () => PreferenceRepositoryImpl(prefs),
  );
}
