import '../entities/locale_settings.dart';
import '../repositories/locale_repository.dart';

class GetLocaleSettingsUseCase {
  const GetLocaleSettingsUseCase(this._repository);

  final LocaleRepository _repository;

  Future<LocaleSettings> call() {
    return _repository.getLocaleSettings();
  }
}
