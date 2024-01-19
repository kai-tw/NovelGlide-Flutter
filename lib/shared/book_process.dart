import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'file_process.dart';

class BookProcess {
  static const String defaultCover = 'assets/images/book_cover_light.jpg';

  static Future<List<BookObject>> getList() async {
    final Directory folder = Directory(await FileProcess.libraryRoot);
    folder.createSync(recursive: true);
    final List<Directory> entries = folder.listSync().whereType<Directory>().toList();
    List<BookObject> list = entries.map((item) => BookObject.fromPath(item.path)).toList();
    list.sort((BookObject a, BookObject b) {
      return compareNatural(a.name, b.name);
    });
    return list;
  }

  static Future<bool> isExists(String name) async {
    final folder = Directory(join(await FileProcess.libraryRoot, name));
    return folder.existsSync();
  }
}

class BookObject {
  String name = '';
  File? coverFile;
  FileImage _coverImage;

  BookObject({this.name = '', this.coverFile}) : _coverImage = FileImage(coverFile!);
  BookObject.fromPath(String path) : this(name: basename(path), coverFile: File(join(path, 'cover.jpg')));
  BookObject.fromObject(BookObject bookObject) : this(name: bookObject.name, coverFile: bookObject.coverFile);

  Future<bool> create() async {
    if (name == '') {
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
    if (newObject.name == '' || name == '') {
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
    if (name == '') {
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

  Widget getCover() {
    if (coverFile != null && coverFile!.existsSync()) {
      return Image(
        image: _coverImage,
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    } else {
      return Image.asset(BookProcess.defaultCover, fit: BoxFit.cover);
    }
  }

  void refreshCover() {
    _coverImage.evict();
  }

  Future<Map<int, String>> getChapters() async {
    if (name == '') {
      return {};
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
      Map<int, String> chapterMap = {};
      for (String item in entries) {
        final File file = File(item);
        final List<String> content = file.readAsLinesSync();
        if (content.isNotEmpty) {
          chapterMap[int.parse(basenameWithoutExtension(file.path))] = content[0];
        } else {
          // If content is empty, delete it.
          file.delete();
        }
      }

      return chapterMap;
    } else {
      return {};
    }
  }
}
