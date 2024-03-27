import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'chapter_object.dart';
import 'file_path.dart';
import 'verify_utility.dart';

class ChapterUtility {
  static List<ChapterObject> getList(String bookName) {
    final Directory folder = Directory(join(filePath.libraryRoot, bookName));

    if (VerifyUtility.isFolderNameValid(bookName) && folder.existsSync()) {
      RegExp regexp = RegExp(r'^\d+\.txt$');
      List<String> entries = folder
          .listSync()
          .whereType<File>()
          .where((item) => regexp.hasMatch(basename(item.path)) && lookupMimeType(item.path) == 'text/plain')
          .map<String>((item) => item.path)
          .toList();
      entries.sort(compareNatural);

      return entries
          .map((e) => ChapterObject(bookName: bookName, ordinalNumber: int.parse(basenameWithoutExtension(e))))
          .toList();
    }

    return [];
  }
}
