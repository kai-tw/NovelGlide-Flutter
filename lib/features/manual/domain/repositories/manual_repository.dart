import '../../../locale_system/domain/entities/app_locale.dart';
import '../entities/shared_manual_path_enum.dart';

abstract class ManualRepository {
  Future<String> loadManual(
    SharedManualPathEnum filePath,
    AppLocale appLocale,
  );
}
