import '../../../../core/use_cases/use_case.dart';
import '../entities/locale_settings.dart';
import '../repositories/locale_repository.dart';

class GetLocaleSettingsUseCase extends UseCase<Future<LocaleSettings>, void> {
  const GetLocaleSettingsUseCase(this._repository);

  final LocaleRepository _repository;

  @override
  Future<LocaleSettings> call([void parameter]) {
    return _repository.getLocaleSettings();
  }
}
