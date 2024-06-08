import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../toolbox/book_processor.dart';

class BookData {
  String name = '';
  File? coverFile;

  BookData({this.name = '', this.coverFile});

  BookData.fromPath(String path)
      : this(name: basename(path), coverFile: File(BookProcessor.getCoverPathByBookPath(path)));

  BookData.fromName(String name) : this.fromPath(BookProcessor.getPathByName(name));

  /// Create the book with the data
  Future<bool> create() async {
    bool isSuccess = BookProcessor.createFolder(name);

    if (isSuccess && coverFile != null) {
      isSuccess = isSuccess && BookProcessor.createCover(name, coverFile!);
    }

    return isSuccess;
  }

  /// Apply the modification to the book
  Future<bool> modify(BookData newObject) async {
    bool isSuccess = true;

    if (newObject.coverFile != coverFile) {
      isSuccess = isSuccess &&
          (newObject.coverFile == null
              ? BookProcessor.deleteCover(name)
              : BookProcessor.modifyCover(name, newObject.coverFile!));
    }

    isSuccess = isSuccess && BookProcessor.modifyFolder(name, newObject.name);

    final File file = File(getCoverPath());
    coverFile = file.existsSync() ? file : null;
    imageCache.clear();
    imageCache.clearLiveImages();

    return isSuccess;
  }

  /// Delete the book
  bool delete() {
    return BookProcessor.deleteFolder(name);
  }

  /// Is the book exists
  bool isExists() {
    return Directory(getPath()).existsSync();
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
