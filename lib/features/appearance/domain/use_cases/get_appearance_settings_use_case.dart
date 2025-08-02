import 'package:novel_glide/features/appearance/domain/entities/appearance_settings.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';

class GetAppearanceSettingsUseCase {
  const GetAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  Future<AppearanceSettings> call() async {
    return _repository.getAppearanceSettings();
  }
}
