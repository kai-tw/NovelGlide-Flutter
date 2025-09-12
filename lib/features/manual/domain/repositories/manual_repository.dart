import '../../../locale_system/domain/entities/app_locale.dart';
import '../entities/shared_manual_file_path.dart';

abstract class ManualRepository {
  Future<String> loadManual(SharedManualFilePath filePath, AppLocale appLocale);
}
