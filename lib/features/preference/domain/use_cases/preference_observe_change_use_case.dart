import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_preference_data.dart';
import '../entities/backup_preference_data.dart';
import '../entities/bookmark_list_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/collection_list_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/reader_preference_data.dart';
import '../repositories/preference_repository.dart';

class PreferenceObserveChangeUseCase<T, U extends PreferenceRepository<T>>
    extends UseCase<Stream<T>, void> {
  PreferenceObserveChangeUseCase(this._repository);

  final U _repository;

  @override
  Stream<T> call([void parameter]) {
    return _repository.onChangeStream;
  }
}

/// Appearance observe change use case.
typedef AppearanceObservePreferenceChangeUseCase
    = PreferenceObserveChangeUseCase<AppearancePreferenceData,
        AppearancePreferenceRepository>;

/// Backup observe change use case.
typedef BackupObservePreferenceChangeUseCase = PreferenceObserveChangeUseCase<
    BackupPreferenceData, BackupPreferenceRepository>;

/// Bookshelf observe change use case.
typedef BookshelfObserveChangeUseCase = PreferenceObserveChangeUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Bookmark List observe change use case.
typedef BookmarkListObserveChangeUseCase = PreferenceObserveChangeUseCase<
    BookmarkListPreferenceData, BookmarkListPreferenceRepository>;

/// Collection List observe change use case.
typedef CollectionListObserveChangeUseCase = PreferenceObserveChangeUseCase<
    CollectionListPreferenceData, CollectionListPreferenceRepository>;

/// Locale observe change use case.
typedef LocaleObservePreferenceChangeUseCase = PreferenceObserveChangeUseCase<
    LocalePreferenceData, LocalePreferenceRepository>;

/// Reader observe change use case.
typedef ReaderObservePreferenceChangeUseCase = PreferenceObserveChangeUseCase<
    ReaderPreferenceData, ReaderPreferenceRepository>;
