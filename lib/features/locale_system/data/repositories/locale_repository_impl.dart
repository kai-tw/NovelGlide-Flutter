import 'package:novel_glide/features/locale_system/domain/entities/locale_settings.dart';

import '../../domain/repositories/locale_repository.dart';
import '../data_sources/locale_local_data_source.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  const LocaleRepositoryImpl({
    required this.localDataSource,
  });

  final LocaleLocalDataSource localDataSource;

  @override
  Future<LocaleSettings> getLocaleSettings() async {
    return localDataSource.getLocaleSettings();
  }

  @override
  Future<void> saveLocaleSettings(LocaleSettings settings) {
    return localDataSource.saveLocaleSettings(settings);
  }
}
