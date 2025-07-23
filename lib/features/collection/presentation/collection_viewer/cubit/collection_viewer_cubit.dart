import 'package:collection/collection.dart';
import 'package:novelglide/enum/sort_order_code.dart';

import '../../../../../core/shared_components/shared_list/shared_list.dart';
import '../../../../../enum/loading_state_code.dart';
import '../../../../book_service/book_service.dart';
import '../../../collection_service.dart';

typedef CollectionViewerState = SharedListState<BookData>;

class CollectionViewerCubit extends SharedListCubit<BookData> {
  factory CollectionViewerCubit(CollectionData collectionData) {
    final CollectionViewerCubit cubit = CollectionViewerCubit._internal(
        collectionData, const CollectionViewerState());
    cubit.refresh();
    return cubit;
  }

  CollectionViewerCubit._internal(this.collectionData, super.initialState);

  CollectionData collectionData;

  @override
  Future<void> refresh() async {
    collectionData = await CollectionService.repository.get(collectionData.id);
    final Set<String> pathSet = collectionData.pathList.toSet();

    if (pathSet.isEmpty) {
      emit(const CollectionViewerState(
        code: LoadingStateCode.loaded,
        dataList: <BookData>[],
      ));
    } else {
      final List<BookData> bookList = <BookData>[];

      for (final String path in collectionData.pathList.toSet()) {
        final String absolutePath =
            BookService.repository.getAbsolutePath(path);
        final BookData target = state.dataList.firstWhereOrNull(
                (BookData e) => e.absoluteFilePath == absolutePath) ??
            await BookService.repository.getBookData(absolutePath);
        bookList.add(target);
        if (!isClosed) {
          emit(CollectionViewerState(
            code: LoadingStateCode.backgroundLoading,
            dataList: List<BookData>.from(bookList),
          ));
        }
      }

      if (!isClosed) {
        emit(state.copyWith(code: LoadingStateCode.loaded));
      }
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

    collectionData.pathList =
        state.dataList.map<String>((BookData e) => e.absoluteFilePath).toList();
    CollectionService.repository.save(collectionData);
  }

  void remove() {
    collectionData.pathList.removeWhere((String p) =>
        state.selectedSet.any((BookData e) => e.relativeFilePath == p));
    CollectionService.repository.save(collectionData);
    refresh();
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
