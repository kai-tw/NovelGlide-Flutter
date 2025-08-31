import 'dart:async';
import 'dart:typed_data';

import 'package:path/path.dart';

import '../../../../core/file_system/domain/repositories/file_system_repository.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../pick_file/domain/repositories/pick_file_repository.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/book_chapter.dart';
import '../../domain/entities/book_cover.dart';
import '../../domain/entities/book_pick_file_data.dart';
import '../../domain/repositories/book_repository.dart';
import '../data_sources/book_local_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  BookRepositoryImpl(
    this._epubDataSource,
    this._fileSystemRepository,
    this._pickFileRepository,
  );

  final BookLocalDataSource _epubDataSource;

  final FileSystemRepository _fileSystemRepository;
  final PickFileRepository _pickFileRepository;

  final StreamController<void> _onChangedController =
      StreamController<void>.broadcast();

  @override
  List<String> get allowedExtensions => _epubDataSource.allowedExtensions;

  @override
  StreamController<void> get onChangedController => _onChangedController;

  @override
  Future<void> addBooks(Set<String> externalPathSet) async {
    await _epubDataSource.addBooks(externalPathSet);

    // Send a notification
    onChangedController.add(null);
  }

  @override
  Future<bool> delete(String identifier) async {
    final bool result = await _epubDataSource.delete(identifier);

    // Send a notification.
    onChangedController.add(null);

    return result;
  }

  @override
  Future<bool> exists(String identifier) {
    return _epubDataSource.exists(identifier);
  }

  @override
  Future<Book> getBook(String identifier) {
    return _epubDataSource.getBook(identifier);
  }

  @override
  Stream<Book> getBooks([Set<String>? identifierSet]) {
    return _epubDataSource.getBooks(identifierSet);
  }

  @override
  Future<Set<BookPickFileData>> pickBooks() async {
    final Set<String> pickedFileSet = await _pickFileRepository.pickFiles(
      allowedExtensions: allowedExtensions,
    );
    final Set<BookPickFileData> dataSet = <BookPickFileData>{};

    for (String absolutePath in pickedFileSet) {
      final String baseName = basename(absolutePath);
      dataSet.add(BookPickFileData(
        absolutePath: absolutePath,
        baseName: baseName,
        fileSize: parseFileLengthToString(
            await _fileSystemRepository.getFileSize(absolutePath)),
        existsInLibrary: await exists(baseName),
        isTypeValid: await isFileValid(absolutePath),
      ));
    }

    return dataSet;
  }

  @override
  Future<Uint8List> readBookBytes(String identifier) async {
    return _epubDataSource.readBookBytes(identifier);
  }

  @override
  Future<BookCover> getCover(String identifier) async {
    return _epubDataSource.getCover(identifier);
  }

  @override
  Future<List<BookChapter>> getChapterList(String identifier) {
    return _epubDataSource.getChapterList(identifier);
  }

  @override
  Future<void> clearTemporaryPickedBooks() {
    return _pickFileRepository.clearTemporaryFiles();
  }

  @override
  Future<void> reset() async {
    await _epubDataSource.deleteAllBooks();

    // Send a notification.
    onChangedController.add(null);
  }

  @override
  Future<bool> isFileValid(String path) {
    return _epubDataSource.isFileValid(path);
  }
}
