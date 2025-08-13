import '../../../../core/domain/use_cases/use_case.dart';
import '../entities/appearance_settings.dart';
import '../repositories/appearance_repository.dart';

class GetAppearanceSettingsUseCase
    extends UseCase<Future<AppearanceSettings>, void> {
  const GetAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  @override
  Future<AppearanceSettings> call([void parameter]) async {
    return _repository.getAppearanceSettings();
  }
}
