import '../../../locale_system/domain/entities/app_locale.dart';
import '../../domain/entities/shared_manual_path_enum.dart';

abstract class ManualRemoteDataSource {
  Future<String> loadManual(
    SharedManualPathEnum filePath,
    AppLocale appLocale,
  );
}
