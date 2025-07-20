import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';

import '../utils/random_extension.dart';
import 'file_path.dart';

class TempService {
  TempService._();

  static TempService? _lazyInstance;

  static TempService get _instance {
    _lazyInstance ??= TempService._();
    return _lazyInstance!;
  }

  static Directory getDirectory() => _instance._getDirectory();

  Directory _getDirectory() {
    final String tempFolderPath = FilePath.tempDirectory;
    Directory tempFolder;

    do {
      tempFolder = Directory(join(tempFolderPath, Random().nextString(8)));
    } while (tempFolder.existsSync());

    tempFolder.createSync(recursive: true);
    return tempFolder;
  }
}
