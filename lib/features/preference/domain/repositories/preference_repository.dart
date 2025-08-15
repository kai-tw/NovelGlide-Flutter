import '../entities/appearance_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/shared_list_preference_data.dart';
import '../entities/tts_preference_data.dart';

abstract class PreferenceRepository<T> {
  Stream<T> get onChangeStream;

  Future<T> getPreference();

  Future<void> savePreference(T data);

  Future<void> resetPreference();
}

typedef AppearancePreferenceRepository
    = PreferenceRepository<AppearancePreferenceData>;
typedef LocalePreferenceRepository = PreferenceRepository<LocalePreferenceData>;
typedef TtsPreferenceRepository = PreferenceRepository<TtsPreferenceData>;

/// SharedList repositories
typedef SharedListPreferenceRepository<T extends SharedListPreferenceData>
    = PreferenceRepository<T>;
typedef BookshelfPreferenceRepository
    = SharedListPreferenceRepository<BookshelfPreferenceData>;
