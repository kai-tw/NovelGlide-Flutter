import 'package:path_provider/path_provider.dart';

class FileProcess {
  static Future<String> get supportFolder async {
    final folder = await getApplicationSupportDirectory();
    return folder.path;
  }
  static Future<String> get documentFolder async {
    final folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }
  static Future<String> get cacheFolder async {
    final folder = await getApplicationCacheDirectory();
    return folder.path;
  }
  static Future<String> get tempFolder async {
    final folder = await getTemporaryDirectory();
    return folder.path;
  }
}