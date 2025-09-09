import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/bookmark_list_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/collection_list_preference_data.dart';
import '../entities/reader_preference_data.dart';
import '../repositories/preference_repository.dart';

class PreferenceResetUseCase<T, U extends PreferenceRepository<T>>
    extends UseCase<Future<void>, void> {
  PreferenceResetUseCase(this._repository);

  final U _repository;

  @override
  Future<void> call([void parameter]) {
    return _repository.resetPreference();
  }
}

/// Bookshelf reset preference use case
typedef BookshelfResetPreferenceUseCase = PreferenceResetUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Bookmark List reset preference use case
typedef BookmarkListResetPreferenceUseCase = PreferenceResetUseCase<
    BookmarkListPreferenceData, BookmarkListPreferenceRepository>;

/// Collection List reset preference use case
typedef CollectionListResetPreferenceUseCase = PreferenceResetUseCase<
    CollectionListPreferenceData, CollectionListPreferenceRepository>;

/// Reader reset preference use case.
typedef ReaderResetPreferenceUseCase
    = PreferenceResetUseCase<ReaderPreferenceData, ReaderPreferenceRepository>;
