import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';

class ChapterData extends Equatable {
  final String title;
  final String? fileName;
  final List<ChapterData>? subChapterList;

  @override
  List<Object?> get props => [title, fileName];

  const ChapterData({
    required this.title,
    this.fileName,
    this.subChapterList,
  });

  factory ChapterData.fromEpubChapter(epub.EpubChapter epubChapter, int ordinalNumber) {
    return ChapterData(
      title: epubChapter.Title ?? "",
      fileName: epubChapter.ContentFileName ?? "",
      subChapterList:
          (epubChapter.SubChapters ?? []).map((e) => ChapterData.fromEpubChapter(e, ordinalNumber)).toList(),
    );
  }
}
