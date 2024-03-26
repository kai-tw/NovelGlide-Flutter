import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';

import 'book_object.dart';
import 'datetime_utility.dart';
import 'file_path.dart';

class BookmarkObject extends Equatable {
  final bool isValid;
  final String bookName;
  final int chapterNumber;
  final double area;
  final DateTime savedTime;
  final int daysPassed;

  @override
  List<Object?> get props => [isValid, bookName, chapterNumber, area, savedTime, daysPassed];

  BookmarkObject({
    this.isValid = false,
    this.bookName = '',
    this.chapterNumber = 0,
    this.area = 0,
    DateTime? savedTime,
  }) : savedTime = savedTime ?? DateTime.now(), daysPassed = DateTimeUtility.daysPassed(savedTime ?? DateTime.now());

  void save() {
    if (_verify()) {
      Box bookmarkBox = Hive.box(name: join(filePath.libraryRoot, bookName, 'bookmark'));
      bookmarkBox.put('isValid', _verify());
      bookmarkBox.put('chapterNumber', chapterNumber);
      bookmarkBox.put('area', area);
      bookmarkBox.put('savedTime', savedTime.toIso8601String());
      bookmarkBox.close();
    }
  }

  void clear() {
    final String boxName = join(filePath.libraryRoot, bookName, 'bookmark');
    Box bookmarkBox = Hive.box(name: boxName);
    bookmarkBox.clear();
    bookmarkBox.close();

    // Delete bookmark.isar
    File file = File('$boxName.isar');
    if (file.existsSync()) {
      file.deleteSync();
    }

    // Delete bookmark.isar.lock
    file = File('$boxName.isar.lock');
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  BookmarkObject copyWith({
    bool? isValid,
    int? chapterNumber,
    double? area,
    DateTime? savedTime,
  }) {
    return BookmarkObject(
      isValid: isValid ?? this.isValid,
      bookName: bookName,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      area: area ?? this.area,
      savedTime: savedTime ?? this.savedTime,
    );
  }

  @override
  String toString() {
    return '{ isValid: $isValid, bookName: $bookName, chapterNumber: $chapterNumber, area: $area, savedTime: $savedTime, daysPassed: $daysPassed }';
  }

  bool _verify() {
    return bookName != '' && chapterNumber > -1 && area >= 0.0 && savedTime.isBefore(DateTime.now());
  }

  static BookmarkObject load(String bookName) {
    Box bookmarkBox = Hive.box(name: join(filePath.libraryRoot, bookName, 'bookmark'));
    final bool isValid = bookmarkBox.get('isValid', defaultValue: false);
    final int chapterNumber = bookmarkBox.get('chapterNumber', defaultValue: -1);
    final double area = bookmarkBox.get('area', defaultValue: 0.0);
    final DateTime savedTime =
    DateTime.parse(bookmarkBox.get('savedTime', defaultValue: DateTime.now().toIso8601String()));
    bookmarkBox.close();

    return BookmarkObject(
      isValid: isValid,
      bookName: bookName,
      chapterNumber: chapterNumber,
      area: area,
      savedTime: savedTime,
    );
  }

  static List<BookmarkObject> getList() {
    List<BookmarkObject> retList = [];
    List<String> bookList = BookObject.getBookList();

    for (String path in bookList) {
      final File file = File(join(path, "bookmark.isar"));
      if (file.existsSync()) {
        final String bookName = basename(path);
        final BookmarkObject bookmarkObject = load(bookName);
        if (bookmarkObject.isValid) {
          retList.add(bookmarkObject);
        } else {
          bookmarkObject.clear();
        }
      }
    }

    return retList;
  }
}
