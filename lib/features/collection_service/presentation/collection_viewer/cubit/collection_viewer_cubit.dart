import 'dart:async';

import 'package:novel_glide/enum/sort_order_code.dart';

import '../../../../../enum/loading_state_code.dart';
import '../../../../../features/shared_components/shared_list/shared_list.dart';
import '../../../../book_service/domain/entities/book.dart';
import '../../../../book_service/domain/use_cases/get_book_list_by_identifier_set_use_case.dart';
import '../../../collection_service.dart';

typedef CollectionViewerState = SharedListState<Book>;

class CollectionViewerCubit extends SharedListCubit<Book> {
  factory CollectionViewerCubit(
    CollectionData collectionData, {
    required GetBookListByIdentifierSetUseCase
        getBookListByIdentifierSetUseCase,
  }) {
    final CollectionViewerCubit cubit = CollectionViewerCubit._(
      collectionData,
      getBookListByIdentifierSetUseCase,
    );

    cubit.refresh();

    return cubit;
  }

  CollectionViewerCubit._(
    this.collectionData,
    this._getBookListByIdentifierSetUseCase,
  ) : super(const CollectionViewerState());

  CollectionData collectionData;
  StreamSubscription<Book>? _listStreamSubscription;

  /// Use cases
  final GetBookListByIdentifierSetUseCase _getBookListByIdentifierSetUseCase;

  /// Refresh the state of viewer.
  @override
  Future<void> refresh() async {
    // Update collection data
    collectionData =
        await CollectionService.repository.getDataById(collectionData.id);

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
    CollectionService.repository.updateData(<CollectionData>{collectionData});
  }

  Future<void> removeBooks() async {
    // Remove books from collection, and update the data.
    collectionData = await CollectionService.repository.removeBooksFromSingle(
      collectionData.id,
      state.selectedSet,
    );

    // Remove books from dataList
    final List<Book> bookList = List<Book>.from(state.dataList);
    bookList.removeWhere((Book e) => state.selectedSet.contains(e));
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      selectedSet: <Book>{},
      dataList: bookList,
    ));
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
