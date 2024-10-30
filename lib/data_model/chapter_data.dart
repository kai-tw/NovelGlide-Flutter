import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';

/// Represents a chapter with a title, optional file name, and a list of subchapters.
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

  /// Factory constructor to create a [ChapterData] instance from an [epub.EpubChapter].
  factory ChapterData.fromEpubChapter(epub.EpubChapter epubChapter) {
    return ChapterData(
      title: epubChapter.Title ?? "",
      fileName: epubChapter.ContentFileName ?? "",
      subChapterList: (epubChapter.SubChapters ?? [])
          .map((e) => ChapterData.fromEpubChapter(e))
          .toList(),
    );
  }
}
