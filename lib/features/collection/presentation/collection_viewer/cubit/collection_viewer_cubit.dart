import 'package:novelglide/enum/sort_order_code.dart';

import '../../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../book_service/book_service.dart';
import '../../../collection_service.dart';

typedef CollectionViewerState = SharedListState<BookData>;

class CollectionViewerCubit extends SharedListCubit<BookData> {
  factory CollectionViewerCubit(CollectionData collectionData) =>
      CollectionViewerCubit._(collectionData)..refresh();

  CollectionViewerCubit._(this.collectionData)
      : super(const CollectionViewerState());

  CollectionData collectionData;

  /// Refresh the state of viewer.
  @override
  Future<void> refresh() async {
    // Update collection data
    collectionData.pathList =
        state.dataList.map((BookData e) => e.absoluteFilePath).toList();

    // Get the path list
    final List<String> pathList = collectionData.pathList;

    if (pathList.isEmpty) {
      // Path list is empty.
      emit(const CollectionViewerState(
        code: LoadingStateCode.loaded,
        dataList: <BookData>[],
      ));
    } else {
      // The current loaded book data list
      final List<BookData> bookList = <BookData>[];

      // Get book data from repository
      BookService.repository
          .getBookListFromPathList(pathList)
          .listen((BookData data) {
        // A new book data is received.
        if (!isClosed) {
          bookList.add(data);
          emit(CollectionViewerState(
            code: LoadingStateCode.backgroundLoading,
            dataList: List<BookData>.from(bookList),
          ));
        }
      }).onDone(() {
        // All book data is received.
        if (!isClosed) {
          emit(CollectionViewerState(
            code: LoadingStateCode.loaded,
            dataList: List<BookData>.from(bookList),
          ));
        }
      });
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      return;
    }

    final BookData target = state.dataList.removeAt(oldIndex);
    state.dataList
        .insert(oldIndex < newIndex ? newIndex - 1 : newIndex, target);
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      dataList: List<BookData>.from(state.dataList),
    ));

    // Update collection data
    collectionData.pathList =
        state.dataList.map((BookData e) => e.absoluteFilePath).toList();

    // Save collection data
    CollectionService.repository.save(collectionData);
  }

  Future<void> removeBooks() async {
    // Remove books from collection
    for (final BookData data in state.selectedSet) {
      await CollectionService.repository.deleteBookFromSingle(
        data.absoluteFilePath,
        collectionData.id,
      );
    }

    // Update collection data
    collectionData =
        await CollectionService.repository.getDataById(collectionData.id);

    // Remove books from dataList
    final List<BookData> bookList = List<BookData>.from(state.dataList);
    bookList.removeWhere((BookData e) => state.selectedSet.contains(e));
    emit(state.copyWith(
      code: LoadingStateCode.loaded,
      selectedSet: <BookData>{},
      dataList: bookList,
    ));
  }

  @override
  void savePreference() {
    // No preferences.
  }

  @override
  int sortCompare(
    BookData a,
    BookData b, {
    required SortOrderCode sortOrder,
    required bool isAscending,
  }) {
    // Custom order. Don't care
    return 0;
  }
}
