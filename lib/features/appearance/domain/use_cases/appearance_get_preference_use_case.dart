import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/appearance_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class AppearanceGetPreferenceUseCase
    extends UseCase<Future<AppearancePreferenceData>, void> {
  const AppearanceGetPreferenceUseCase(this._repository);

  final AppearancePreferenceRepository _repository;

  @override
  Future<AppearancePreferenceData> call([void parameter]) async {
    return _repository.getPreference();
  }
}
