part of '../../book_service.dart';

class BookData extends Equatable {
  const BookData({
    required this.absoluteFilePath,
    required this.name,
    this.coverImage,
  });

  final String absoluteFilePath;
  final String name;
  final epub.Image? coverImage;

  @override
  List<Object?> get props => <Object?>[absoluteFilePath, name, coverImage];

  /// Get the file of this book_service.
  File get file => File(absoluteFilePath);

  /// Determine whether this book_service exists.
  bool get isExist => file.existsSync();

  /// Get the last modified date of this book_service.
  DateTime get modifiedDate => file.statSync().modified;

  /// Get the relative path of this book_service.
  Future<String> get relativeFilePath =>
      BookService.repository.getRelativePath(absoluteFilePath);

  /// Get the list of chapters from this book_service.
  Future<List<ChapterData>> get chapterList =>
      BookService.repository.getChapterList(absoluteFilePath);
}
