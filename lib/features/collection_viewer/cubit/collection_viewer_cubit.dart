import 'package:collection/collection.dart';

import '../../../data_model/book_data.dart';
import '../../../data_model/collection_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../repository/book_repository.dart';
import '../../../repository/collection_repository.dart';
import '../../common_components/common_list/list_template.dart';

class CollectionViewerCubit extends CommonListCubit<BookData> {
  factory CollectionViewerCubit(CollectionData collectionData) {
    final CollectionViewerCubit cubit = CollectionViewerCubit._internal(
        collectionData, const CommonListState<BookData>());
    cubit.refresh();
    return cubit;
  }

  CollectionViewerCubit._internal(this.collectionData, super.initialState);

  CollectionData collectionData;

  @override
  Future<void> refresh() async {
    collectionData = CollectionRepository.get(collectionData.id);
    final Set<String> pathSet = collectionData.pathList.toSet();

    if (pathSet.isEmpty) {
      emit(const CommonListState<BookData>(
        code: LoadingStateCode.loaded,
        dataList: <BookData>[],
      ));
    } else {
      final List<BookData> bookList = <BookData>[];

      for (final String path in collectionData.pathList.toSet()) {
        final String absolutePath = BookRepository.getAbsolutePath(path);
        final BookData target = state.dataList.firstWhereOrNull(
                (BookData e) => e.absoluteFilePath == absolutePath) ??
            await BookRepository.get(absolutePath);
        bookList.add(target);
        if (!isClosed) {
          emit(CommonListState<BookData>(
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
    CollectionRepository.save(collectionData);
  }

  void remove() {
    collectionData.pathList.removeWhere((String p) =>
        state.selectedSet.any((BookData e) => e.relativeFilePath == p));
    CollectionRepository.save(collectionData);
    refresh();
  }
}
