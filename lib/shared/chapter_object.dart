import 'dart:io';

import 'package:path/path.dart';

import 'file_path.dart';
import 'verify_utility.dart';

class ChapterObject {
  String bookName;
  int ordinalNumber;
  String? _title;

  ChapterObject({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return join(filePath.libraryRoot, bookName, "$ordinalNumber.txt");
  }

  String getTitle({bool isForce = false}) {
    if (_title == null || isForce) {
      final List<String> content = getContent();
      _title = content.isNotEmpty ? content[0] : "";
    }
    return _title!;
  }

  List<String> getContent() {
    final File file = File(getPath());
    if (!file.existsSync()) {
      return [];
    }
    return file.readAsLinesSync().where((line) => line.isNotEmpty).toList();
  }

  bool isExist() {
    return File(getPath()).existsSync();
  }

  Future<bool> create(File file, {String? title}) async {
    // Copy file.
    await file.copy(getPath());

    final File newFile = File(getPath());

    // Write title into file.
    if (title != null) {
      String content = await newFile.readAsString();

      // Prepend the title to the content.
      content = "$title\n\n$content";
      await newFile.writeAsString(content);
    }

    return await newFile.exists();
  }
}
