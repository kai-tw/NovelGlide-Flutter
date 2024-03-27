import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'file_path.dart';
import 'verify_utility.dart';

class BookObject {
  String name = '';
  File? coverFile;
  FileImage? _coverImage;

  BookObject({this.name = '', this.coverFile});

  BookObject.fromPath(String path) : this(name: basename(path), coverFile: File(join(path, 'cover.jpg')));
  BookObject.fromObject(BookObject bookObject) : this(name: bookObject.name, coverFile: bookObject.coverFile);
  BookObject.fromName(String name) : this.fromPath(join(filePath.libraryRoot, name));

  /// File process
  Future<bool> create() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return false;
    }
    final Directory folder = Directory(join(filePath.libraryRoot, name));
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

  bool modify(BookObject newObject) {
    if (!VerifyUtility.isFolderNameValid(newObject.name) || !VerifyUtility.isFolderNameValid(name)) {
      return false;
    }

    bool isSuccess = true;
    final Directory oldFolder = Directory(join(filePath.libraryRoot, name));
    final Directory newFolder = Directory(join(filePath.libraryRoot, newObject.name));

    if (newObject.coverFile != coverFile) {
      if (newObject.coverFile == null) {
        // Delete cover.
        if (coverFile != null && coverFile!.existsSync()) {
          coverFile!.delete();
        }
        coverFile = null;
      } else {
        // Change cover.
        File newCoverImage = newObject.coverFile!.copySync(join(newFolder.path, 'cover.jpg'));
        isSuccess = isSuccess && newCoverImage.existsSync();
      }
    }

    if (newObject.name != name) {
      oldFolder.renameSync(newFolder.path);
      isSuccess = isSuccess && newFolder.existsSync();
      name = isSuccess ? newObject.name : name;
      coverFile = coverFile == null ? null : File(join(newFolder.path, 'cover.jpg'));
    }

    return isSuccess;
  }

  bool delete() {
    if (VerifyUtility.isFolderNameValid(name)) {
      final Directory folder = Directory(join(filePath.libraryRoot, name));
      if (folder.existsSync()) {
        folder.deleteSync(recursive: true);
        return !folder.existsSync();
      }
    }
    return false;
  }

  bool isExists() {
    return VerifyUtility.isFolderNameValid(name) && Directory(join(filePath.libraryRoot, name)).existsSync();
  }

  String? getCoverPath() {
    final File file = File(join(getPath(), 'cover.jpg'));
    return file.existsSync() ? file.path : null;
  }

  /// Cover of this book
  Widget getCover() {
    if (coverFile != null && coverFile!.existsSync()) {
      _coverImage = FileImage(coverFile!);
      return Image(
        image: _coverImage!,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    } else {
      _coverImage = null;
      return Image.asset('assets/images/book_cover_light.jpg', fit: BoxFit.cover);
    }
  }

  void refreshCover() {
    if (_coverImage != null) {
      _coverImage!.evict();
    }
  }

  String getPath() {
    return join(filePath.libraryRoot, name);
  }
}
