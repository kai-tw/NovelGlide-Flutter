import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_preference_data.dart';
import '../entities/bookmark_list_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/collection_list_preference_data.dart';
import '../entities/locale_preference_data.dart';
import '../entities/tts_preference_data.dart';
import '../repositories/preference_repository.dart';

class PreferenceGetUseCase<T, U extends PreferenceRepository<T>>
    extends UseCase<Future<T>, void> {
  PreferenceGetUseCase(this._repository);

  final U _repository;

  @override
  Future<T> call([void parameter]) {
    return _repository.getPreference();
  }
}

/// Appearance get preference use case
typedef AppearanceGetPreferenceUseCase = PreferenceGetUseCase<
    AppearancePreferenceData, AppearancePreferenceRepository>;

/// Bookshelf get preference use case
typedef BookshelfGetPreferenceUseCase = PreferenceGetUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Bookmark List get preference use case
typedef BookmarkListGetPreferenceUseCase = PreferenceGetUseCase<
    BookmarkListPreferenceData, BookmarkListPreferenceRepository>;

/// Collection List get preference use case
typedef CollectionListGetPreferenceUseCase = PreferenceGetUseCase<
    CollectionListPreferenceData, CollectionListPreferenceRepository>;

/// Locale get preference use case
typedef LocaleGetPreferenceUseCase
    = PreferenceGetUseCase<LocalePreferenceData, LocalePreferenceRepository>;

/// TTS get preference use case
typedef TtsGetPreferenceUseCase
    = PreferenceGetUseCase<TtsPreferenceData, TtsPreferenceRepository>;
