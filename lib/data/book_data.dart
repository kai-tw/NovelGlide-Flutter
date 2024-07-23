import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../processor/book_processor.dart';

class BookData {
  String name = '';
  File? coverFile;

  BookData({this.name = '', this.coverFile});

  BookData.fromName(this.name)
      : coverFile = File(BookProcessor.getCoverPathByName(name)).existsSync()
            ? File(BookProcessor.getCoverPathByName(name))
            : null;

  BookData.fromPath(String path) : this.fromName(basename(path));

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

    final File file = File(getCoverPath());
    coverFile = file.existsSync() ? file : null;
    imageCache.clear();
    imageCache.clearLiveImages();

    return isSuccess;
  }

  /// Delete the book
  bool delete() {
    return BookProcessor.delete(name);
  }

  /// Is the book exists
  bool isExist() {
    return BookProcessor.isExist(name);
  }

  /// Get the cover path
  String getCoverPath() {
    return BookProcessor.getCoverPathByName(name);
  }

  /// Get the book path
  String getPath() {
    return BookProcessor.getPathByName(name);
  }

  /// Copy the book data with the provided data
  BookData copyWith({String? name, File? coverFile}) {
    return BookData(
      name: name ?? this.name,
      coverFile: coverFile ?? this.coverFile,
    );
  }
}
