import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../../data/book_data.dart';
import '../../../processor/book_processor.dart';
import '../../../processor/bookmark_processor.dart';
import '../../../processor/chapter_processor.dart';
import '../../../toolbox/random_utility.dart';

class ChapterImporterCubit extends Cubit<ChapterImporterState> {
  ChapterImporterCubit(this.bookData) : super(const ChapterImporterState());

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

  void setState({
    bool? isOverwriteChapter,
    bool? isOverwriteCover,
    bool? isOverwriteBookmark,
  }) {
    emit(state.copyWith(
      isOverwriteChapter: isOverwriteChapter ?? state.isOverwriteChapter,
      isOverwriteCover: isOverwriteCover ?? state.isOverwriteCover,
      isOverwriteBookmark: isOverwriteBookmark ?? state.isOverwriteBookmark,
    ));
  }

  /// Import books from an archive file.
  Future<bool> importFromArchive(String bookName, File archiveFile) async {
    Directory tempFolder = RandomUtility.getAvailableTempFolder();

    try {
      await ZipFile.extractToDirectory(zipFile: archiveFile, destinationDir: tempFolder);
    } catch (e) {
      tempFolder.deleteSync(recursive: true);
      rethrow;
    }

    final File coverFile = File(join(tempFolder.path, BookProcessor.coverFileName));

    await ChapterProcessor.importFromFolder(bookName, tempFolder, isOverwrite: state.isOverwriteChapter);
    BookProcessor.importCover(bookName, coverFile, isOverwrite: state.isOverwriteCover);
    BookmarkProcessor.import(bookName, tempFolder.path, isOverwrite: state.isOverwriteBookmark);

    tempFolder.deleteSync(recursive: true);
    return true;
  }
}

class ChapterImporterState extends Equatable {
  final bool isOverwriteChapter;
  final bool isOverwriteCover;
  final bool isOverwriteBookmark;

  @override
  List<Object?> get props => [isOverwriteChapter, isOverwriteCover, isOverwriteBookmark];

  const ChapterImporterState({
    this.isOverwriteChapter = false,
    this.isOverwriteCover = false,
    this.isOverwriteBookmark = false,
  });

  ChapterImporterState copyWith({
    bool? isOverwriteChapter,
    bool? isOverwriteCover,
    bool? isOverwriteBookmark,
  }) {
    return ChapterImporterState(
      isOverwriteChapter: isOverwriteChapter ?? this.isOverwriteChapter,
      isOverwriteCover: isOverwriteCover ?? this.isOverwriteCover,
      isOverwriteBookmark: isOverwriteBookmark ?? this.isOverwriteBookmark,
    );
  }
}
