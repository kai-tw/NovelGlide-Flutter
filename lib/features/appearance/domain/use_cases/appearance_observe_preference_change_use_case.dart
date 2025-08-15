import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/appearance_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class AppearanceObservePreferenceChangeUseCase
    extends UseCase<Stream<AppearancePreferenceData>, void> {
  const AppearanceObservePreferenceChangeUseCase(this._repository);

  final AppearancePreferenceRepository _repository;

  @override
  Stream<AppearancePreferenceData> call([void parameter]) {
    return _repository.onChangeStream;
  }
}
