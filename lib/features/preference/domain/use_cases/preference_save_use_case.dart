import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/bookshelf_preference_data.dart';
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

/// Bookshelf save preference use case
typedef BookshelfSavePreferenceUseCase = PreferenceSaveUseCase<
    BookshelfPreferenceData, BookshelfPreferenceRepository>;
