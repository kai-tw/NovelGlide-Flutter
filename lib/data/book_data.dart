import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../processor/book_processor.dart';

class BookData {
  String name = '';
  File? coverFile;

  String get coverPath => BookProcessor.getCoverPathByName(name);
  DateTime get modifiedDate => BookProcessor.getDirectoryByName(name).statSync().modified;

  BookData({this.name = '', this.coverFile});

  factory BookData.fromName(String name) {
    File coverFile = File(BookProcessor.getCoverPathByName(name));
    return BookData(name: name, coverFile: coverFile.existsSync() ? coverFile : null);
  }

  factory BookData.fromPath(String path) => BookData.fromName(basename(path));

  /// Create the book with the data
  Future<bool> create() async {
    bool isSuccess = BookProcessor.create(name);

    if (isSuccess && coverFile != null) {
      isSuccess = isSuccess && BookProcessor.createCover(name, coverFile!);
    }

    return isSuccess;
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
  bool delete() => BookProcessor.delete(name);

  /// Is the book exists
  bool isExist() => BookProcessor.isExist(name);

  /// Copy the book data with the provided data
  BookData copyWith({String? name, File? coverFile}) {
    return BookData(
      name: name ?? this.name,
      coverFile: coverFile ?? this.coverFile,
    );
  }
}
