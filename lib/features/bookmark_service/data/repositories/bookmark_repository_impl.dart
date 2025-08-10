import 'dart:async';

import 'package:novel_glide/features/bookmark_service/domain/entities/bookmark_data.dart';

import '../../../books/domain/repository/book_repository.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../data_sources/bookmark_local_json_data_source.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  BookmarkRepositoryImpl(this._localJsonDataSource, this._bookRepository);

  final BookmarkLocalJsonDataSource _localJsonDataSource;
  final BookRepository _bookRepository;

  final StreamController<void> _onChangedController =
      StreamController<void>.broadcast();

  @override
  Future<void> deleteData(Set<BookmarkData> dataSet) async {
    await _localJsonDataSource.deleteData(dataSet);

    // Send a notification
    _onChangedController.add(null);
  }

  @override
  Future<BookmarkData?> getDataById(String id) {
    return _localJsonDataSource.getDataById(id);
  }

  @override
  Future<List<BookmarkData>> getList() async {
    final List<BookmarkData> list = await _localJsonDataSource.getList();
    final Set<BookmarkData> deleted = <BookmarkData>{};

    // Filter the book doesn't exist
    for (BookmarkData data in list) {
      if (!await _bookRepository.exists(data.bookIdentifier)) {
        deleted.add(data);
        list.remove(data);
      }
    }

    // Delete the data
    if (deleted.isNotEmpty) {
      await deleteData(deleted);
    }

    return list;
  }

  @override
  Stream<void> get onChangedStream => _onChangedController.stream;

  @override
  Future<void> reset() async {
    await _localJsonDataSource.reset();

    // Send a notification
    _onChangedController.add(null);
  }

  @override
  Future<void> updateData(Set<BookmarkData> dataSet) async {
    await _localJsonDataSource.updateData(dataSet);

    // Send a notification
    _onChangedController.add(null);
  }
}
