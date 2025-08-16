import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/locale_preference_data.dart';
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

/// Bookshelf save preference use case
typedef BookshelfSavePreferenceUseCase = PreferenceSaveUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Locale save preference use case
typedef LocaleSavePreferenceUseCase
    = PreferenceSaveUseCase<LocalePreferenceData, LocalePreferenceRepository>;
