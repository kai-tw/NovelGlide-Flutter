import 'dart:io';

import 'package:equatable/equatable.dart';

import '../processor/chapter_processor.dart';

class ChapterData extends Equatable {
  final String bookName;
  final int ordinalNumber;
  final String title;

  @override
  List<Object?> get props => [bookName, ordinalNumber, title];

  const ChapterData({
    required this.bookName,
    required this.ordinalNumber,
    required this.title,
  });

  String getPath() {
    return ChapterProcessor.getPath(bookName, ordinalNumber);
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

  @override
  String toString() {
    return "ChapterData(bookName: $bookName, ordinalNumber: $ordinalNumber)";
  }
}
