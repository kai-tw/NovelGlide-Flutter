import 'package:novel_glide/features/appearance/domain/entities/appearance_settings.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';

class SaveAppearanceSettingsUseCase {
  const SaveAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  Future<void> call(AppearanceSettings settings) async {
    return _repository.saveAppearanceSettings(settings);
  }
}
