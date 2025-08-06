import 'package:novel_glide/features/appearance/domain/entities/appearance_settings.dart';
import 'package:novel_glide/features/appearance/domain/repositories/appearance_repository.dart';

import '../../../../core/use_cases/use_case.dart';

class GetAppearanceSettingsUseCase
    extends UseCase<Future<AppearanceSettings>, void> {
  const GetAppearanceSettingsUseCase(this._repository);

  final AppearanceRepository _repository;

  @override
  Future<AppearanceSettings> call([void parameter]) async {
    return _repository.getAppearanceSettings();
  }
}
