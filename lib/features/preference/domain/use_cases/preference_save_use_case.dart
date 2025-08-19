import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_preference_data.dart';
import '../entities/backup_preference_data.dart';
import '../entities/bookmark_list_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/collection_list_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/reader_preference_data.dart';
import '../repositories/preference_repository.dart';

class PreferenceSaveUseCase<T, U extends PreferenceRepository<T>>
    extends UseCase<Future<void>, T> {
  PreferenceSaveUseCase(this._repository);

  final U _repository;

  @override
  Future<void> call(T parameter) {
    return _repository.savePreference(parameter);
  }
}

/// Appearance save preference use case
typedef AppearanceSavePreferenceUseCase = PreferenceSaveUseCase<
    AppearancePreferenceData, AppearancePreferenceRepository>;

/// Backup save preference use case
typedef BackupSavePreferenceUseCase
    = PreferenceSaveUseCase<BackupPreferenceData, BackupPreferenceRepository>;

/// Bookshelf save preference use case
typedef BookshelfSavePreferenceUseCase = PreferenceSaveUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Bookmark List save preference use case
typedef BookmarkListSavePreferenceUseCase = PreferenceSaveUseCase<
    BookmarkListPreferenceData, BookmarkListPreferenceRepository>;

/// Collection List save preference use case
typedef CollectionListSavePreferenceUseCase = PreferenceSaveUseCase<
    CollectionListPreferenceData, CollectionListPreferenceRepository>;

/// Locale save preference use case
typedef LocaleSavePreferenceUseCase
    = PreferenceSaveUseCase<LocalePreferenceData, LocalePreferenceRepository>;

/// Reader save preference use case
typedef ReaderSavePreferenceUseCase
    = PreferenceSaveUseCase<ReaderPreferenceData, ReaderPreferenceRepository>;
