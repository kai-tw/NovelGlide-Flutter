import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_settings.dart';
import '../repositories/appearance_repository.dart';

class SaveAppearanceSettingsUseCase
    extends UseCase<Future<void>, AppearanceSettings> {
  const SaveAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  @override
  Future<void> call(AppearanceSettings parameter) async {
    return _repository.saveAppearanceSettings(parameter);
  }
}
