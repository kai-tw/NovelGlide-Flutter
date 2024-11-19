import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:image/image.dart';

import '../utils/epub_utils.dart';
import 'chapter_data.dart';

/// Represents a book with its metadata and operations.
class BookData extends Equatable {
  final String absoluteFilePath;
  final String name;
  final Image? coverImage;

  File get _file => File(absoluteFilePath);

  bool get isExist => _file.existsSync();

  DateTime get modifiedDate => _file.statSync().modified;

  @override
  List<Object?> get props => [absoluteFilePath, name, coverImage];

  /// Constructor for creating a BookData instance.
  const BookData({
    required this.absoluteFilePath,
    required this.name,
    this.coverImage,
  });

  /// Retrieve a list of chapters from the book.
  Future<List<ChapterData>> getChapterList() async {
    return EpubUtils.getChapterList(absoluteFilePath);
  }
}
