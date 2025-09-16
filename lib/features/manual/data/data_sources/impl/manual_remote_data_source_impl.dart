import 'package:path/path.dart';

import '../../../../../core/http_client/domain/repositories/http_client_repository.dart';
import '../../../../locale_system/domain/entities/app_locale.dart';
import '../../../domain/entities/shared_manual_path_enum.dart';
import '../manual_remote_data_source.dart';

class ManualRemoteDataSourceImpl implements ManualRemoteDataSource {
  ManualRemoteDataSourceImpl(this._httpClientRepository);

  static const String _remoteRootPath = 'https://novelglide.github.io/';

  final HttpClientRepository _httpClientRepository;

  @override
  Future<String> loadManual(
    SharedManualPathEnum filePath,
    AppLocale appLocale,
  ) async {
    final String fullPath =
        join(_remoteRootPath, filePath.toString(), '$appLocale.md');
    return (await _httpClientRepository.get<String>(Uri.parse(fullPath)))!;
  }
}
