import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'file_path.dart';
import 'verify_utility.dart';

class ChapterObject {
  String bookName;
  int ordinalNumber;
  String title;

  ChapterObject({
    required this.bookName,
    required this.ordinalNumber,
    required this.title,
  });

  static List<ChapterObject> getList(String bookName) {
    final Directory folder = Directory(join(filePath.libraryRoot, bookName));
    final List<ChapterObject> chapterList = [];
    if (folder.existsSync()) {
      List<String> entries = [];

      if (VerifyUtility.isFolderNameValid(bookName)) {
        final folder = Directory(join(filePath.libraryRoot, bookName));
        if (folder.existsSync()) {
          RegExp regexp = RegExp(r'^\d+\.txt$');
          entries = folder
              .listSync()
              .whereType<File>()
              .where((item) => regexp.hasMatch(basename(item.path)) && lookupMimeType(item.path) == 'text/plain')
              .map<String>((item) => item.path)
              .toList();
          entries.sort(compareNatural);
        }
      }

      for (String item in entries) {
        final File file = File(item);
        final List<String> content = file.readAsLinesSync();
        if (content.isNotEmpty) {
          chapterList.add(ChapterObject(
            bookName: bookName,
            ordinalNumber: int.parse(basenameWithoutExtension(item)),
            title: content[0],
          ));
        } else {
          // If content is empty, delete it.
          file.delete();
        }
      }
    }
    return chapterList;
  }

  static List<String> getContent(String bookName, int chapterNumber) {
    final File file = File(join(filePath.libraryRoot, bookName, "$chapterNumber.txt"));
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }
}
