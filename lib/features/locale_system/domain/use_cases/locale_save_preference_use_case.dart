import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/locale_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class LocaleSavePreferenceUseCase
    extends UseCase<Future<void>, LocalePreferenceData> {
  const LocaleSavePreferenceUseCase(this._repository);

  final LocalePreferenceRepository _repository;

  @override
  Future<void> call(LocalePreferenceData parameter) {
    return _repository.savePreference(parameter);
  }
}
