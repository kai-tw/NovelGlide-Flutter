import 'package:collection/collection.dart';

import '../data_model/book_data.dart';
import '../data_model/chapter_data.dart';
import '../enum/sort_order_code.dart';

class BookUtils {
  BookUtils._();

  /// Helper method to find a chapter by file name recursively.
  static ChapterData? getChapterByFileName(
    List<ChapterData>? chapterList,
    String fileName,
  ) {
    // Search for the first matching chapter.
    ChapterData? target = chapterList
        ?.firstWhereOrNull((ChapterData e) => e.fileName == fileName);

    if (target != null) {
      // Found the chapter, return it.
      return target;
    }
    for (ChapterData chapter in chapterList ?? <ChapterData>[]) {
      // Not found, search the sub chapters.
      target ??= getChapterByFileName(chapter.subChapterList, fileName);
    }
    return target;
  }

  /// Helper method to get the chapter title by file name.
  static String getChapterTitleByFileName(
    List<ChapterData>? chapterList,
    String fileName, {
    String defaultValue = '',
  }) {
    final ChapterData? target = getChapterByFileName(chapterList, fileName);
    return target?.title ?? defaultValue;
  }

  /// Provides a comparison function for sorting books.
  /// Based on the given [sortOrder] and [isAscending].
  static int Function(BookData, BookData) sortCompare(
    SortOrderCode sortOrder,
    bool isAscending,
  ) {
    switch (sortOrder) {
      case SortOrderCode.modifiedDate:
        return (BookData a, BookData b) => isAscending
            ? a.modifiedDate.compareTo(b.modifiedDate)
            : b.modifiedDate.compareTo(a.modifiedDate);

      default:
        return (BookData a, BookData b) => isAscending
            ? compareNatural(a.name, b.name)
            : compareNatural(b.name, a.name);
    }
  }
}
