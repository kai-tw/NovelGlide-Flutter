import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';

class ChapterData extends Equatable {
  final String bookName;
  final int ordinalNumber;
  final String title;
  final String? fileName;
  final List<ChapterData>? subChapterList;

  @override
  List<Object?> get props => [bookName, ordinalNumber, title, fileName];

  const ChapterData({
    required this.bookName,
    required this.ordinalNumber,
    required this.title,
    this.fileName,
    this.subChapterList,
  });

  factory ChapterData.fromEpubChapter(epub.EpubChapter epubChapter, int ordinalNumber) {
    return ChapterData(
      bookName: '',
      ordinalNumber: ordinalNumber,
      title: epubChapter.Title ?? "",
      fileName: epubChapter.ContentFileName ?? "",
      subChapterList:
          (epubChapter.SubChapters ?? []).map((e) => ChapterData.fromEpubChapter(e, ordinalNumber)).toList(),
    );
  }
}
