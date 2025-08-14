import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/tts_preference_data.dart';
import '../repositories/tts_preference_repository.dart';

class TtsGetPreferenceUseCase extends UseCase<Future<TtsPreferenceData>, void> {
  const TtsGetPreferenceUseCase(this._repository);

  final TtsPreferenceRepository _repository;

  @override
  Future<TtsPreferenceData> call([void parameter]) {
    return _repository.getPreference();
  }
}
