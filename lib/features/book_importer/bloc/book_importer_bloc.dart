import 'dart:io';

import 'package:epubx/epubx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../data/zip_encoding.dart';
import '../../../processor/book_processor.dart';
import '../../../processor/chapter_processor.dart';
import '../../../toolbox/random_utility.dart';

class BookImporterCubit extends Cubit<BookImporterState> {
  File? _importFile;
  ZipEncoding? _zipEncoding;

  BookImporterCubit() : super(const BookImporterState());

  Future<bool> submit() async {
    String? mimeType = lookupMimeType(_importFile!.path);
    switch (mimeType) {
      case 'application/zip':
        return await importFromArchive(_importFile!);
      case 'application/epub+zip':
        EpubBook epubBook = await EpubReader.readBook(_importFile!.readAsBytesSync());
        print(epubBook.Title);
        print(epubBook.Author);
        print(epubBook.Content?.Html?["ch01.xhtml"]?.Content);
        print(epubBook.CoverImage);
        print(epubBook.Chapters);
        break;
    }
    return false;
  }

  void setImportFile(File? importFile) {
    _importFile = importFile;
  }

  void setZipEncoding(ZipEncoding? zipEncoding) {
    _zipEncoding = zipEncoding;
  }

  /// Import books from an archive file.
  Future<bool> importFromArchive(File archiveFile) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(
        zipFile: archiveFile,
        destinationDir: tempFolder,
        zipFileCharset: _zipEncoding?.value ?? ZipEncoding.utf8.value,
      );
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      return false;
    }

    final List<Directory> bookFolders = tempFolder.listSync().whereType<Directory>().toList();

    for (Directory bookFolder in bookFolders) {
      final String bookName = basename(bookFolder.path);
      BookProcessor.create(bookName);
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
