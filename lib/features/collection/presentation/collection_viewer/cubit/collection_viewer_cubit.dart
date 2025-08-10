import 'dart:async';

import 'package:novel_glide/enum/sort_order_code.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../../books/domain/entities/book.dart';
import '../../../../books/domain/use_cases/book_get_list_by_identifiers_use_case.dart';
import '../../../domain/entities/collection_data.dart';
import '../../../domain/use_cases/collection_get_data_use_case.dart';
import '../../../domain/use_cases/collection_update_data_use_case.dart';

typedef CollectionViewerState = SharedListState<Book>;

class CollectionViewerCubit extends SharedListCubit<Book> {
  CollectionViewerCubit(
    this._getBookListByIdentifierSetUseCase,
    this._getCollectionDataByIdUseCase,
    this._updateCollectionDataUseCase,
  ) : super(const CollectionViewerState());

  late CollectionData collectionData;
  StreamSubscription<Book>? _listStreamSubscription;

  /// Use cases
  final BookGetListByIdentifiersUseCase _getBookListByIdentifierSetUseCase;
  final CollectionGetDataUseCase _getCollectionDataByIdUseCase;
  final CollectionUpdateDataUseCase _updateCollectionDataUseCase;

  /// Get the data from UI.
  void init(CollectionData data) {
    collectionData = data;

    refresh();
  }

  /// Refresh the state of viewer.
  @override
  Future<void> refresh() async {
    // Update collection data
    collectionData = await _getCollectionDataByIdUseCase(collectionData.id);

    // Get the path list
    final List<String> pathList = collectionData.pathList;

    if (pathList.isEmpty) {
      // Path list is empty.
      emit(const CollectionViewerState(
        code: LoadingStateCode.loaded,
        dataList: <Book>[],
      ));
    } else {
      // The current loaded book data list
      final List<Book> bookList = <Book>[];

      // Get book data from repository
      _listStreamSubscription =
          _getBookListByIdentifierSetUseCase(pathList.toSet()).listen(
        (Book data) {
          // A new book data is received.
          if (!isClosed) {
            bookList.add(data);
            emit(CollectionViewerState(
              code: LoadingStateCode.backgroundLoading,
              dataList: List<Book>.from(bookList),
            ));
          }
        },
        onDone: () {
          // All book data is received.
          if (!isClosed) {
            emit(CollectionViewerState(
              code: LoadingStateCode.loaded,
              dataList: List<Book>.from(bookList),
            ));
          }
        },
      );
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      return;
    }

    final Book target = state.dataList.removeAt(oldIndex);
    state.dataList
        .insert(oldIndex < newIndex ? newIndex - 1 : newIndex, target);
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: List<Book>.from(state.dataList),
    ));

    // Save the new order to the past list.
    for (int i = 0; i < state.dataList.length; i++) {
      collectionData.pathList[i] = state.dataList[i].identifier;
    }

    // Save collection data
    _updateCollectionDataUseCase(<CollectionData>{collectionData});
  }

  Future<void> removeBooks() async {
    // Remove books from collection, and update the data.
    for (Book book in state.selectedSet) {
      collectionData.pathList.remove(book.identifier);
    }

    // Remove books from dataList
    final List<Book> bookList = List<Book>.from(state.dataList);
    bookList.removeWhere((Book e) => state.selectedSet.contains(e));
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      selectedSet: <Book>{},
      dataList: bookList,
    ));

    // Save the collection data
    _updateCollectionDataUseCase(<CollectionData>{collectionData});
  }

  @override
  int sortCompare(
    Book a,
    Book b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    // Custom order. Don't care
    return 0;
  }

  @override
  void savePreference() {
    // No preferences.
  }

  @override
  Future<void> refreshPreference() async {
    // No preferences.
  }

  @override
  Future<void> close() {
    _listStreamSubscription?.cancel();
    return super.close();
  }
}
