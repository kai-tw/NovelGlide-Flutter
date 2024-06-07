import 'dart:io';

import 'package:collection/collection.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../data/chapter_data.dart';
import '../data/file_path.dart';
import '../features/common_components/common_file_picker/common_file_picker_type.dart';
import 'verify_utility.dart';

class ChapterUtility {
  static List<ChapterData> getList(String bookName) {
    final Directory folder = Directory(join(FilePath.instance.libraryRoot, bookName));

    if (VerifyUtility.isFolderNameValid(bookName) && folder.existsSync()) {
      RegExp regexp = RegExp(r'^\d+\.txt$');
      List<String> entries = folder
          .listSync()
          .whereType<File>()
          .where((item) =>
              regexp.hasMatch(basename(item.path)) &&
              CommonFilePickerTypeMap.mime[CommonFilePickerType.txt]!.contains(lookupMimeType(item.path)))
          .map<String>((item) => item.path)
          .toList();
      entries.sort(compareNatural);

      return entries
          .map((e) => ChapterData(bookName: bookName, ordinalNumber: int.parse(basenameWithoutExtension(e))))
          .toList();
    }

    return [];
  }
}
