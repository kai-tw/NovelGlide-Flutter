import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../data/book_data.dart';
import '../../../toolbox/book_processor.dart';
import '../../../toolbox/bookmark_processor.dart';
import '../../../toolbox/chapter_processor.dart';
import '../../../toolbox/random_utility.dart';

class BookImporterCubit extends Cubit<BookImporterState> {
  BookImporterCubit(this.bookData) : super(const BookImporterState());

  BookData bookData;
  File? importFile;

  Future<bool> submit() async {
    String? mimeType = lookupMimeType(importFile!.path);
    switch (mimeType) {
      case 'application/zip':
        return await importFromArchive(bookData.name, importFile!);
    }
    return false;
  }

  /// Import books from an archive file.
  static Future<bool> importFromArchive(String bookName, File archiveFile) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(zipFile: archiveFile, destinationDir: tempFolder);
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      rethrow;
    }

    bool isSuccess = true;

    List<File> chapterFiles = tempFolder
        .listSync()
        .whereType<File>()
        .where((file) =>
            ChapterProcessor.chapterRegexp.hasMatch(basename(file.path)) &&
            int.tryParse(basenameWithoutExtension(file.path)) != null)
        .toList();
    ChapterProcessor.import(bookName: bookName, chapterFiles: chapterFiles);

    final File coverFile = File(join(tempFolder.path, BookProcessor.coverFileName));
    if (!BookProcessor.isCoverExist(bookName) && coverFile.existsSync()) {
      isSuccess = isSuccess && BookProcessor.createCover(bookName, coverFile);
    }

    BookmarkProcessor.importBookmark(bookName, tempFolder.path);

    tempFolder.deleteSync(recursive: true);
    return isSuccess;
  }
}

class BookImporterState extends Equatable {
  @override
  List<Object?> get props => [];

  const BookImporterState();
}
