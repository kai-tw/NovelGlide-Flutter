import 'package:path/path.dart';

import '../../../locale_system/domain/entities/app_locale.dart';
import '../../domain/repositories/manual_repository.dart';
import '../../presentation/cubit/shared_manual_file_path.dart';
import '../data_sources/manual_local_data_source.dart';

class ManualRepositoryImpl implements ManualRepository {
  ManualRepositoryImpl(this._localDataSource);

  final ManualLocalDataSource _localDataSource;

  @override
  Future<String> loadManual(
    SharedManualFilePath filePath,
    AppLocale appLocale,
  ) async {
    final String fileName = join(filePath.toString(), '$appLocale.md');
    return await _localDataSource
        .loadManual(join(SharedManualFilePath.assetRootPath, fileName));
  }
}
