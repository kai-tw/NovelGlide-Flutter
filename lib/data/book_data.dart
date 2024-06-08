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

  BookData.fromObject(BookData bookData) : this(name: bookData.name, coverFile: bookData.coverFile);

  BookData.fromName(String name) : this.fromPath(BookProcessor.getPathByName(name));

  /// File process
  Future<bool> create() async {
    bool isSuccess = BookProcessor.createFolder(name);

    if (isSuccess && coverFile != null) {
      isSuccess = isSuccess && BookProcessor.createCover(name, coverFile!);
    }

    return isSuccess;
  }

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

  bool delete() {
    return BookProcessor.deleteFolder(name);
  }

  bool isExists() {
    return Directory(getPath()).existsSync();
  }

  String getCoverPath() {
    return BookProcessor.getCoverPathByName(name);
  }

  String getPath() {
    return BookProcessor.getPathByName(name);
  }
}
