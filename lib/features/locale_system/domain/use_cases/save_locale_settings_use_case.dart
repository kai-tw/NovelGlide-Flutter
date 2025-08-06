import '../../../../core/use_cases/use_case.dart';
import '../entities/locale_settings.dart';
import '../repositories/locale_repository.dart';

class SaveLocaleSettingsUseCase extends UseCase<Future<void>, LocaleSettings> {
  const SaveLocaleSettingsUseCase(this._repository);

  final LocaleRepository _repository;

  @override
  Future<void> call(LocaleSettings parameter) {
    return _repository.saveLocaleSettings(parameter);
  }
}
