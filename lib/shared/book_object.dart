import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'chapter_object.dart';
import 'file_process.dart';
import 'verify_utility.dart';

class BookObject {
  String name = '';
  File? coverFile;
  FileImage? _coverImage;

  BookObject({this.name = '', this.coverFile}) : _coverImage = coverFile != null ? FileImage(coverFile) : null;

  BookObject.fromPath(String path) : this(name: basename(path), coverFile: File(join(path, 'cover.jpg')));

  BookObject.fromObject(BookObject bookObject) : this(name: bookObject.name, coverFile: bookObject.coverFile);

  Future<bool> create() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return false;
    }
    final folder = Directory(join(await FileProcess.libraryRoot, name));
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

  Future<bool> rename(BookObject newObject) async {
    if (!VerifyUtility.isFolderNameValid(newObject.name) || !VerifyUtility.isFolderNameValid(name)) {
      return false;
    }

    bool isSuccess = true;
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    final newFolder = Directory(join(await FileProcess.libraryRoot, newObject.name));

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

  Future<bool> delete() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return false;
    }
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    if (folder.existsSync()) {
      folder.delete(recursive: true);
      return !folder.existsSync();
    } else {
      return false;
    }
  }

  Future<bool> isExists() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return false;
    }
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    return folder.existsSync();
  }

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

  Future<List<ChapterObject>> getChapters() async {
    if (!VerifyUtility.isFolderNameValid(name)) {
      return [];
    }
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    if (folder.existsSync()) {
      RegExp regexp = RegExp(r'^\d+\.txt$');
      List<String> entries = folder
          .listSync()
          .whereType<File>()
          .where((item) => regexp.hasMatch(basename(item.path)) && lookupMimeType(item.path) == 'text/plain')
          .map<String>((item) => item.path)
          .toList();
      entries.sort(compareNatural);
      List<ChapterObject> chapterList = [];
      for (String item in entries) {
        final File file = File(item);
        final List<String> content = file.readAsLinesSync();
        if (content.isNotEmpty) {
          chapterList.add(
              ChapterObject(ordinalNumber: int.parse(basenameWithoutExtension(item)), title: content[0], file: file));
        } else {
          // If content is empty, delete it.
          file.delete();
        }
      }

      return chapterList;
    } else {
      return [];
    }
  }
}
