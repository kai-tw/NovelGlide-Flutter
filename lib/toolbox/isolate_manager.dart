import 'package:hive/hive.dart';

import '../data/app_info.dart';
import '../data/file_path.dart';

class IsolateManager {
  static Future<void> ensureInitialized() async {
    await AppInfo.instance.init();
    await FilePath.instance.init();
    Hive.defaultDirectory = FilePath.instance.hiveRoot;
  }
}