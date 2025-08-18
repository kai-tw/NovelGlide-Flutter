import '../entities/appearance_preference_data.dart';
import '../entities/backup_preference_data.dart';
import '../entities/bookmark_list_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/collection_list_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/shared_list_preference_data.dart';
import '../entities/tts_preference_data.dart';

abstract class PreferenceRepository<T> {
  Stream<T> get onChangeStream;

  Future<T> getPreference();

  Future<void> savePreference(T data);

  Future<void> resetPreference();
}

/// Appearance preference repository.
typedef AppearancePreferenceRepository
    = PreferenceRepository<AppearancePreferenceData>;

/// Locale preference repository.
typedef LocalePreferenceRepository = PreferenceRepository<LocalePreferenceData>;

/// TTS preference repository.
typedef TtsPreferenceRepository = PreferenceRepository<TtsPreferenceData>;

/// Backup preference repository.
typedef BackupPreferenceRepository = PreferenceRepository<BackupPreferenceData>;

/// ========== Start of SharedList repositories ==========
/// SharedList preference repository contrast.
typedef SharedListPreferenceRepository<T extends SharedListPreferenceData>
    = PreferenceRepository<T>;

/// Bookshelf preference repository.
typedef BookshelfPreferenceRepository
    = SharedListPreferenceRepository<BookshelfPreferenceData>;

/// Bookmark List preference repository.
typedef BookmarkListPreferenceRepository
    = SharedListPreferenceRepository<BookmarkListPreferenceData>;

/// Collection List preference repository
typedef CollectionListPreferenceRepository
    = SharedListPreferenceRepository<CollectionListPreferenceData>;

/// ========== End of SharedList repositories ==========
