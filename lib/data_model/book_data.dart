import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:image/image.dart';

import '../utils/epub_utils.dart';
import 'chapter_data.dart';

/// Represents a book with its metadata and operations.
class BookData {
  final String filePath;
  String name;
  Image? _coverImage;

  Image? get coverImage => _coverImage;

  File get _file => File(filePath);

  bool get isExist => _file.existsSync();

  DateTime get modifiedDate => _file.statSync().modified;

  /// Constructor for creating a BookData instance.
  BookData._internal(this.filePath, this.name, this._coverImage);

  /// Factory constructor to create a BookData instance from an EpubBook.
  factory BookData.fromEpub(String path, epub.EpubBook epubBook) {
    return BookData._internal(path, epubBook.Title ?? '', epubBook.CoverImage);
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
