import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/appearance_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class AppearanceSavePreferenceUseCase
    extends UseCase<Future<void>, AppearancePreferenceData> {
  const AppearanceSavePreferenceUseCase(this._repository);

  final AppearancePreferenceRepository _repository;

  @override
  Future<void> call(AppearancePreferenceData parameter) async {
    return _repository.savePreference(parameter);
  }
}
