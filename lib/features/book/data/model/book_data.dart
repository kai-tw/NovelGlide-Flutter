import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:image/image.dart';

import '../../../../enum/sort_order_code.dart';
import '../../../../utils/epub_utils.dart';
import '../repository/book_repository.dart';
import 'chapter_data.dart';

class BookData extends Equatable {
  const BookData({
    required this.absoluteFilePath,
    required this.name,
    this.coverImage,
  });

  final String absoluteFilePath;
  final String name;
  final Image? coverImage;

  @override
  List<Object?> get props => <Object?>[absoluteFilePath, name, coverImage];

  /// Get the file of this book.
  File get _file => File(absoluteFilePath);

  /// Determine whether this book exists.
  bool get isExist => _file.existsSync();

  /// Get the last modified date of this book.
  DateTime get modifiedDate => _file.statSync().modified;

  /// Get the relative path of this book.
  String get relativeFilePath =>
      BookRepository.getRelativePath(absoluteFilePath);

  /// Get the list of chapters from this book.
  Future<List<ChapterData>> get chapterList async {
    return EpubUtils.getChapterList(absoluteFilePath);
  }

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
