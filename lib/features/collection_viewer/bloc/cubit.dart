part of '../collection_viewer.dart';

typedef _State = CommonListState<BookData>;

class _Cubit extends CommonListCubit<BookData> {
  CollectionData collectionData;

  factory _Cubit(CollectionData collectionData) {
    final cubit = _Cubit._internal(collectionData, const _State());
    cubit.refresh();
    return cubit;
  }

  _Cubit._internal(this.collectionData, super.initialState);

  @override
  Future<void> refresh() async {
    collectionData = CollectionRepository.get(collectionData.id);
    List<BookData> bookList = [];

    for (final path in collectionData.pathList.toSet()) {
      final absolutePath = BookRepository.getAbsolutePath(path);
      final target = state.dataList
              .firstWhereOrNull((e) => e.absoluteFilePath == absolutePath) ??
          await BookRepository.get(absolutePath);
      bookList.add(target);
    }

    emit(_State(
      code: LoadingStateCode.loaded,
      dataList: bookList,
    ));
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      return;
    }

    BookData target = state.dataList.removeAt(oldIndex);
    state.dataList
        .insert(oldIndex < newIndex ? newIndex - 1 : newIndex, target);
    emit(_State(
      code: LoadingStateCode.loaded,
      dataList: state.dataList,
    ));

    collectionData.pathList =
        state.dataList.map<String>((e) => e.absoluteFilePath).toList();
    CollectionRepository.save(collectionData);
  }

  void remove() {
    collectionData.pathList.removeWhere(
        (p) => state.selectedSet.any((e) => e.relativeFilePath == p));
    CollectionRepository.save(collectionData);
    refresh();
  }
}
