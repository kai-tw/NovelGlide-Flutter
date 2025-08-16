import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_preference_data.dart';
import '../entities/bookshelf_preference_data.dart';
import '../entities/locale_preference_data.dart';
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

/// Bookshelf observe change use case.
typedef BookshelfObserveChangeUseCase = PreferenceObserveChangeUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;

/// Locale observe change use case.
typedef LocaleObservePreferenceChangeUseCase = PreferenceObserveChangeUseCase<
    LocalePreferenceData, LocalePreferenceRepository>;
