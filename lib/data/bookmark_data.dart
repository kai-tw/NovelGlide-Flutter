import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import '../processor/chapter_processor.dart';
import '../toolbox/datetime_utility.dart';
import 'file_path.dart';

class BookmarkData extends Equatable {
  final bool isValid;
  final String bookName;
  final int chapterNumber;
  final double scrollPosition;
  final DateTime savedTime;
  final int daysPassed;

  @override
  List<Object?> get props => [isValid, bookName, chapterNumber, scrollPosition, savedTime, daysPassed];

  BookmarkData({
    this.isValid = false,
    this.bookName = '',
    this.chapterNumber = 0,
    this.scrollPosition = 0,
    DateTime? savedTime,
  })  : savedTime = savedTime ?? DateTime.now(),
        daysPassed = DateTimeUtility.daysPassed(savedTime ?? DateTime.now());

  factory BookmarkData.fromDirectory(String directory) {
    Box bookmarkBox = Hive.box(name: 'bookmark', directory: directory);
    final bool isValid = bookmarkBox.get('isValid', defaultValue: false);
    final int chapterNumber = bookmarkBox.get('chapterNumber', defaultValue: -1);
    final double area = bookmarkBox.get('area', defaultValue: 0.0);
    final DateTime savedTime =
        DateTime.parse(bookmarkBox.get('savedTime', defaultValue: DateTime.now().toIso8601String()));
    bookmarkBox.close();

    return BookmarkData(
      isValid: isValid,
      bookName: "",
      chapterNumber: chapterNumber,
      scrollPosition: area,
      savedTime: savedTime,
    );
  }

  factory BookmarkData.fromBookName(String bookName) {
    final BookmarkData data = BookmarkData.fromDirectory(join(FilePath.instance.libraryRoot, bookName));
    final bool isValid = data.isValid && ChapterProcessor.isExist(bookName, data.chapterNumber);
    return data.copyWith(isValid: isValid, bookName: bookName);
  }

  void save() {
    Box bookmarkBox = Hive.box(name: 'bookmark', directory: join(FilePath.instance.libraryRoot, bookName));
    bookmarkBox.put('isValid', bookName != '' && chapterNumber > -1 && savedTime.isBefore(DateTime.now()));
    bookmarkBox.put('chapterNumber', chapterNumber);
    bookmarkBox.put('area', scrollPosition);
    bookmarkBox.put('savedTime', savedTime.toIso8601String());
    bookmarkBox.close();
  }

  void clear() {
    Box bookmarkBox = Hive.box(name: 'bookmark', directory: join(FilePath.instance.libraryRoot, bookName));
    bookmarkBox.clear();
    bookmarkBox.close();
  }

  BookmarkData copyWith({
    bool? isValid,
    String? bookName,
    int? chapterNumber,
    double? scrollPosition,
    DateTime? savedTime,
  }) {
    return BookmarkData(
      isValid: isValid ?? this.isValid,
      bookName: bookName ?? this.bookName,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  @override
  String toString() {
    return '{ isValid: $isValid, bookName: $bookName, chapterNumber: $chapterNumber, area: $scrollPosition, savedTime: $savedTime, daysPassed: $daysPassed }';
  }
}
