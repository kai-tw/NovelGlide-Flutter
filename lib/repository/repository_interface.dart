import 'dart:io';

import 'package:path/path.dart';

import '../utils/file_path.dart';

class RepositoryInterface {
  static String getJsonPath(String fileName) {
    return join(FilePath.dataRoot, fileName);
  }

  static File getJsonFile(String jsonPath) {
    final file = File(jsonPath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }
}
