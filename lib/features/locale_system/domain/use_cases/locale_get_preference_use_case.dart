import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/locale_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class LocaleGetPreferenceUseCase
    extends UseCase<Future<LocalePreferenceData>, void> {
  const LocaleGetPreferenceUseCase(this._repository);

  final LocalePreferenceRepository _repository;

  @override
  Future<LocalePreferenceData> call([void parameter]) {
    return _repository.getPreference();
  }
}
