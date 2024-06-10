import 'dart:io';

import '../toolbox/chapter_processor.dart';

class ChapterData {
  String bookName;
  int ordinalNumber;
  String? _title;

  ChapterData({
    required this.bookName,
    required this.ordinalNumber,
  });

  String getPath() {
    return ChapterProcessor.getPath(bookName, ordinalNumber);
  }

  Future<String> getTitle() async {
    return await ChapterProcessor.getTitle(bookName, ordinalNumber);
  }

  Future<String> getTitleFromCache({bool isForceUpdate = false}) async {
    if (_title == null || isForceUpdate) {
      _title = await getTitle();
    }
    return _title!;
  }

  Future<List<String>> getContent() async {
    return await ChapterProcessor.getContent(bookName, ordinalNumber);
  }

  bool isExist() {
    return File(getPath()).existsSync();
  }

  Future<bool> create(File file, {String? title}) async {
    return await ChapterProcessor.create(bookName, ordinalNumber, file, title: title);
  }

  Future<bool> delete() async {
    return await ChapterProcessor.delete(bookName, ordinalNumber);
  }
}
