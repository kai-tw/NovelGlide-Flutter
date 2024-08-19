import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';

import '../processor/chapter_processor.dart';

class ChapterData extends Equatable {
  final String bookName;
  final int ordinalNumber;
  final String title;
  final String? fileName;
  final String? htmlContent;
  final List<ChapterData>? subChapterList;

  @override
  List<Object?> get props => [bookName, ordinalNumber, title, fileName, htmlContent];

  const ChapterData({
    required this.bookName,
    required this.ordinalNumber,
    required this.title,
    this.fileName,
    this.htmlContent,
    this.subChapterList,
  });

  factory ChapterData.fromEpubChapter(epub.EpubChapter epubChapter, int ordinalNumber) {
    return ChapterData(
      bookName: '',
      ordinalNumber: ordinalNumber,
      title: epubChapter.Title ?? "",
      fileName: epubChapter.ContentFileName ?? "",
      htmlContent: epubChapter.HtmlContent ?? "",
      subChapterList:
          (epubChapter.SubChapters ?? []).map((e) => ChapterData.fromEpubChapter(e, ordinalNumber)).toList(),
    );
  }

  Future<bool> create(File file, {String? title}) async {
    return await ChapterProcessor.create(bookName, ordinalNumber, file, title: title);
  }

  Future<bool> delete() async {
    return await ChapterProcessor.delete(bookName, ordinalNumber);
  }
}
