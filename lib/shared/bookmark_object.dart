import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

class BookmarkObject extends Equatable {
  final bool isValid;
  final int chapterNumber;
  final double area;
  final DateTime savedTime;

  const BookmarkObject({
    required this.isValid,
    required this.chapterNumber,
    required this.area,
    required this.savedTime,
  });

  static BookmarkObject load(String bookName) {
    Box bookmarkBox = Hive.box(name: join('bookmarks', bookName));
    final bool isValid = bookmarkBox.get('isValid', defaultValue: false);
    final int chapterNumber = bookmarkBox.get('chapterNumber', defaultValue: -1);
    final double area = bookmarkBox.get('area', defaultValue: 0.0);
    final DateTime savedTime =
        DateTime.parse(bookmarkBox.get('savedTime', defaultValue: DateTime.now().toIso8601String()));
    bookmarkBox.close();

    BookmarkObject bookmarkObject = BookmarkObject(
      isValid: isValid,
      chapterNumber: chapterNumber,
      area: area,
      savedTime: savedTime,
    );
    print(bookmarkObject);
    return bookmarkObject;
  }

  void save(String bookName) {
    Box bookmarkBox = Hive.box(name: join('bookmarks', bookName));
    bookmarkBox.put('isValid', _verify());
    bookmarkBox.put('chapterNumber', chapterNumber);
    bookmarkBox.put('area', area);
    bookmarkBox.put('savedTime', savedTime.toIso8601String());
    bookmarkBox.close();
  }

  void clear(String bookName) {
    Box bookmarkBox = Hive.box(name: join('bookmarks', bookName));
    bookmarkBox.put('isValid', false);
    bookmarkBox.close();
  }

  BookmarkObject copyWith({
    bool? isValid,
    int? chapterNumber,
    double? area,
    DateTime? savedTime,
  }) {
    return BookmarkObject(
      isValid: isValid ?? this.isValid,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      area: area ?? this.area,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  @override
  String toString() {
    return '{isValid: $isValid, chapterNumber: $chapterNumber, area: $area, savedTime: $savedTime}';
  }

  bool _verify() {
    return chapterNumber > -1 && area >= 0.0 && savedTime.isBefore(DateTime.now());
  }

  @override
  List<Object?> get props => [isValid, chapterNumber, area, savedTime];
}
