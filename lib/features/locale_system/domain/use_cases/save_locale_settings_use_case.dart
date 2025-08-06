import '../entities/locale_settings.dart';
import '../repositories/locale_repository.dart';

class SaveLocaleSettingsUseCase {
  const SaveLocaleSettingsUseCase(this._repository);

  final LocaleRepository _repository;

  Future<void> call(LocaleSettings settings) {
    return _repository.saveLocaleSettings(settings);
  }
}
