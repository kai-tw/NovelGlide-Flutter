import 'package:novel_glide/features/appearance/domain/entities/appearance_settings.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';

import '../../../../core/use_cases/use_case.dart';

class SaveAppearanceSettingsUseCase
    extends UseCase<Future<void>, AppearanceSettings> {
  const SaveAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  @override
  Future<void> call(AppearanceSettings parameter) async {
    return _repository.saveAppearanceSettings(parameter);
  }
}
