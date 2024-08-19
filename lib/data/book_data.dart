import 'dart:io';

import 'package:epubx/epubx.dart' as epub;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../processor/book_processor.dart';
import 'chapter_data.dart';

class BookData {
  String name;
  Uint8List? coverBytes;
  String filePath;
  List<ChapterData>? chapterList = [];
  epub.EpubBook? epubBook;

  File? coverFile;

  File get file => File(filePath);
  bool get isExist => file.existsSync();

  DateTime get modifiedDate => file.statSync().modified;

  String get coverPath => BookProcessor.getCoverPathByName(name);

  BookData({
    this.name = '',
    this.filePath = '',
    this.coverBytes,
    this.chapterList,
    this.epubBook,

    this.coverFile,
  });

  factory BookData.fromName(String name) {
    File coverFile = File(BookProcessor.getCoverPathByName(name));
    return BookData(name: name, coverFile: coverFile.existsSync() ? coverFile : null);
  }

  factory BookData.fromEpub(epub.EpubBook epubBook, String filePath) {
    List<ChapterData> chapterList = [];

    for (int i = 0; i < (epubBook.Chapters ?? []).length; i++) {
      epub.EpubChapter epubChapter = epubBook.Chapters![i];
      chapterList.add(ChapterData.fromEpubChapter(epubChapter, i + 1));
    }

    return BookData(
      name: epubBook.Title ?? '',
      filePath: filePath,
      coverBytes: epubBook.CoverImage?.getBytes(),
      chapterList: chapterList,
      epubBook: epubBook,
    );
  }

  /// Apply the modification to the book
  Future<bool> modify(BookData newData) async {
    bool isSuccess = true;

    if (newData.coverFile != coverFile) {
      isSuccess = isSuccess &&
          (newData.coverFile == null
              ? BookProcessor.deleteCover(name)
              : BookProcessor.modifyCover(name, newData.coverFile!));
    }

    if (newData.name != name) {
      isSuccess = isSuccess && BookProcessor.modify(name, newData.name);
    }

    final File file = File(coverPath);
    coverFile = file.existsSync() ? file : null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      imageCache.clear();
      imageCache.clearLiveImages();
    });

    return isSuccess;
  }

  /// Delete the book
  bool delete() {
    if (file.existsSync()) {
      file.deleteSync();
    }
    return !file.existsSync();
  }

  /// Copy the book data with the provided data
  BookData copyWith({String? name, File? coverFile}) {
    return BookData(
      name: name ?? this.name,
      coverFile: coverFile ?? this.coverFile,
    );
  }
}
