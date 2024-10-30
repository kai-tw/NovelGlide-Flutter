import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:image/image.dart';

import '../utils/epub_utils.dart';
import 'chapter_data.dart';

/// Represents a book with its metadata and operations.
class BookData {
  final String filePath;
  String name;
  Image? coverImage;

  /// Returns the file object for the book.
  File get _file => File(filePath);

  /// Checks if the book file exists.
  bool get isExist => _file.existsSync();

  /// Returns the last modified date of the book file.
  DateTime get modifiedDate => _file.statSync().modified;

  /// Constructor for creating a BookData instance.
  BookData({required this.filePath, required this.name, this.coverImage});

  /// Factory constructor to create a BookData instance from an EpubBook.
  factory BookData.fromEpubBook(String path, epub.EpubBook epubBook) {
    return BookData(
      filePath: path,
      name: epubBook.Title ?? '',
      coverImage: epubBook.CoverImage,
    );
  }

  /// Retrieve a list of chapters from the book.
  Future<List<ChapterData>> getChapterList() async {
    return EpubUtils.getChapterList(filePath);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookData &&
          runtimeType == other.runtimeType &&
          filePath == other.filePath;

  @override
  int get hashCode => filePath.hashCode;
}
