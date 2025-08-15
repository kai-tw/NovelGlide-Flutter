import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/locale_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class LocaleObservePreferenceChangeUseCase
    extends UseCase<Stream<LocalePreferenceData>, void> {
  const LocaleObservePreferenceChangeUseCase(this._repository);

  final LocalePreferenceRepository _repository;

  @override
  Stream<LocalePreferenceData> call([void parameter]) {
    return _repository.onChangeStream;
  }
}
