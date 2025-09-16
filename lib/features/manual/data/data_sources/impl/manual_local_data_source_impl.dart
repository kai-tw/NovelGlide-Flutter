import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../../../../locale_system/domain/entities/app_locale.dart';
import '../../../domain/entities/shared_manual_path_enum.dart';
import '../manual_local_data_source.dart';

class ManualLocalDataSourceImpl implements ManualLocalDataSource {
  static const String _assetRootPath = 'assets/manuals/';

  @override
  Future<String> loadManual(
    SharedManualPathEnum filePath,
    AppLocale appLocale,
  ) {
    final String fileName = join(filePath.toString(), '$appLocale.md');
    return rootBundle.loadString(join(_assetRootPath, fileName));
  }
}
