import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../app_path_provider_data_source.dart';

class AppPathProviderLocalDataSource extends AppPathProviderDataSource {
  @override
  Future<String> get cachePath async =>
      (await getApplicationCacheDirectory()).path;

  @override
  Future<String> get documentPath async {
    final Directory directory = await (Platform.isIOS
        ? getLibraryDirectory()
        : getApplicationDocumentsDirectory());
    return directory.path;
  }

  @override
  Future<String> get tempPath async => (await getTemporaryDirectory()).path;
}
