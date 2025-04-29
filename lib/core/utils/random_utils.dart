import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';

import 'file_path.dart';

class RandomUtils {
  // Private constructor to prevent instantiation
  RandomUtils._();

  // Generates a random string of the specified length
  static String getRandomString(int length) {
    const String alphabet =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(
      Iterable<int>.generate(
        length,
        (_) => alphabet.codeUnitAt(Random().nextInt(alphabet.length)),
      ),
    );
  }

  // Finds an available temporary folder and creates it
  static Directory getAvailableTempFolder() {
    final String tempFolderPath = FilePath.tempFolder;
    Directory tempFolder;

    do {
      tempFolder = Directory(join(tempFolderPath, getRandomString(8)));
    } while (tempFolder.existsSync());

    tempFolder.createSync(recursive: true);
    return tempFolder;
  }
}
