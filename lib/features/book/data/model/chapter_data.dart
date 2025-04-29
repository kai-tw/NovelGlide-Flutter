import 'package:epubx/epubx.dart' as epub;
import 'package:equatable/equatable.dart';

class ChapterData extends Equatable {
  const ChapterData({
    required this.title,
    this.fileName,
    this.subChapterList,
  });

  factory ChapterData.fromEpubChapter(epub.EpubChapter epubChapter) {
    return ChapterData(
      title: epubChapter.Title ?? '',
      fileName: epubChapter.ContentFileName ?? '',
      subChapterList: (epubChapter.SubChapters ?? <epub.EpubChapter>[])
          .map((epub.EpubChapter e) => ChapterData.fromEpubChapter(e))
          .toList(),
    );
  }

  final String title;
  final String? fileName;
  final List<ChapterData>? subChapterList;

  @override
  List<Object?> get props => <Object?>[
        title,
        fileName,
        subChapterList,
      ];
}
