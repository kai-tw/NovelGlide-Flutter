import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'file_process.dart';
import 'verify_utility.dart';

class BookObject {
  String name = '';
  File? coverFile;
  FileImage? _coverImage;

  BookObject({this.name = '', this.coverFile})
      : _coverImage = coverFile != null ? FileImage(coverFile) : null;

  BookObject.fromPath(String path) : this(name: basename(path), coverFile: File(join(path, 'cover.jpg')));
  BookObject.fromObject(BookObject bookObject) : this(name: bookObject.name, coverFile: bookObject.coverFile);
  BookObject.fromName(String name) : this.fromPath(FileProcess.getBookPathByName(name));

  /// File process
  Future<bool> create() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return false;
    }
    final folder = FileProcess.getBookDirectoryByName(name);
    if (folder.existsSync()) {
      return false;
    } else {
      bool isSuccess = true;
      folder.createSync(recursive: true);
      isSuccess = isSuccess && folder.existsSync();
      if (coverFile != null) {
        File coverImage = coverFile!.copySync(join(folder.path, 'cover.jpg'));
        isSuccess = isSuccess && coverImage.existsSync();
      }
      return isSuccess;
    }
  }

  bool rename(BookObject newObject) {
    if (!VerifyUtility.isFolderNameValid(newObject.name) || !VerifyUtility.isFolderNameValid(name)) {
      return false;
    }

    bool isSuccess = true;
    final folder = FileProcess.getBookDirectoryByName(name);
    final newFolder = FileProcess.getBookDirectoryByName(newObject.name);

    if (newObject.name != name) {
      folder.renameSync(newFolder.path);
      isSuccess = isSuccess && newFolder.existsSync();
      name = isSuccess ? newObject.name : name;
    }

    if (newObject.coverFile != coverFile) {
      File newCoverImage = newObject.coverFile!.copySync(join(newFolder.path, 'cover.jpg'));
      isSuccess = isSuccess && newCoverImage.existsSync();
    } else {
      if (coverFile != null && coverFile!.existsSync()) {
        coverFile!.delete();
      }
      coverFile = null;
    }
    return isSuccess;
  }

  bool delete() {
    if (VerifyUtility.isFolderNameValid(name)) {
      final folder = FileProcess.getBookDirectoryByName(name);
      if (folder.existsSync()) {
        folder.delete(recursive: true);
        return !folder.existsSync();
      }
    }
    return false;
  }

  bool isExists() {
    return VerifyUtility.isFolderNameValid(name) && FileProcess.getBookDirectoryByName(name).existsSync();
  }

  /// Cover of this book
  Widget getCover() {
    if (coverFile != null && coverFile!.existsSync()) {
      return Image(
        image: _coverImage!,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    } else {
      return Image.asset('assets/images/book_cover_light.jpg', fit: BoxFit.cover);
    }
  }

  void refreshCover() {
    if (_coverImage != null) {
      _coverImage!.evict();
    }
  }
}
