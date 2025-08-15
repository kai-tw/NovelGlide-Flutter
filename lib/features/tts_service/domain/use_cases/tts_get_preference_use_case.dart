import '../../../../core/domain/use_cases/use_case.dart';
import '../../../preference/domain/entities/tts_preference_data.dart';
import '../../../preference/domain/repositories/preference_repository.dart';

class TtsGetPreferenceUseCase extends UseCase<Future<TtsPreferenceData>, void> {
  const TtsGetPreferenceUseCase(this._repository);

  final TtsPreferenceRepository _repository;

  @override
  Future<TtsPreferenceData> call([void parameter]) {
    return _repository.getPreference();
  }
}
