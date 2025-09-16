import '../../../locale_system/domain/entities/app_locale.dart';
import '../../domain/entities/shared_manual_path_enum.dart';
import '../../domain/repositories/manual_repository.dart';
import '../data_sources/manual_local_data_source.dart';
import '../data_sources/manual_remote_data_source.dart';

class ManualRepositoryImpl implements ManualRepository {
  ManualRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  final ManualLocalDataSource _localDataSource;
  final ManualRemoteDataSource _remoteDataSource;

  @override
  Future<String> loadManual(
    SharedManualPathEnum filePath,
    AppLocale appLocale,
  ) async {
    switch (filePath.loadType) {
      case SharedManualLoadType.local:
        return _localDataSource.loadManual(filePath, appLocale);

      case SharedManualLoadType.remote:
        return _remoteDataSource.loadManual(filePath, appLocale);

      case SharedManualLoadType.both:
        try {
          // Load online first.
          return await _remoteDataSource.loadManual(filePath, appLocale);
        } catch (_) {
          // Use local as fallback.
          return await _localDataSource.loadManual(filePath, appLocale);
        }
    }
  }
}
