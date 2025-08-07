part of '../../book_service.dart';

class BookData extends Equatable {
  const BookData({
    required this.absoluteFilePath,
    required this.name,
  });

  final String absoluteFilePath;
  final String name;

  @override
  List<Object?> get props => <Object?>[absoluteFilePath, name];

  /// Get the file of this book.
  File get file => File(absoluteFilePath);
}
