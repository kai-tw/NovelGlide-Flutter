import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';

import '../data/file_path.dart';

class RandomUtility {
  static String getRandomString(int length) {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(length, (_) => alphabet.codeUnitAt(Random().nextInt(alphabet.length))));
  }

  static Directory getAvailableTempFolder() {
    Directory tempFolder = Directory(join(FilePath.instance.tempFolder, RandomUtility.getRandomString(8)));
    while (tempFolder.existsSync()) {
      tempFolder = Directory(join(FilePath.instance.tempFolder, RandomUtility.getRandomString(8)));
    }
    tempFolder.createSync(recursive: true);
    return tempFolder;
  }
}