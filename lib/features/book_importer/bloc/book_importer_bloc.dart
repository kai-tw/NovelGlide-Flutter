import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../processor/book_processor.dart';
import '../../../processor/chapter_processor.dart';
import '../../../toolbox/random_utility.dart';

class BookImporterCubit extends Cubit<BookImporterState> {
  File? importFile;

  BookImporterCubit() : super(const BookImporterState());

  Future<bool> submit() async {
    String? mimeType = lookupMimeType(importFile!.path);
    switch (mimeType) {
      case 'application/zip':
        return await importFromArchive(importFile!);
    }
    return false;
  }

  /// Import books from an archive file.
  Future<bool> importFromArchive(File archiveFile) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(zipFile: archiveFile, destinationDir: tempFolder);
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      rethrow;
    }

    final List<Directory> bookFolders = tempFolder.listSync().whereType<Directory>().toList();

    for (Directory bookFolder in bookFolders) {
      final String bookName = basename(bookFolder.path);
      BookProcessor.createFolder(bookName);
      await ChapterProcessor.importFromFolder(bookName, bookFolder);
    }

    tempFolder.deleteSync(recursive: true);
    return true;
  }
}

class BookImporterState extends Equatable {
  @override
  List<Object?> get props => [];

  const BookImporterState();
}