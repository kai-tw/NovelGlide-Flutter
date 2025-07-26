part of '../collection_add_book_scaffold.dart';

class CollectionAddBookCubit extends Cubit<CollectionAddBookState> {
  factory CollectionAddBookCubit(Set<BookData> dataSet) {
    final CollectionAddBookCubit cubit = CollectionAddBookCubit._(dataSet);
    cubit.refresh();
    return cubit;
  }

  CollectionAddBookCubit._(this._dataSet)
      : super(const CollectionAddBookState());

  final Set<BookData> _dataSet;

  Future<void> refresh() async {
    final List<CollectionData> collectionList =
        await CollectionService.repository.getList();
    final Set<String> pathSet =
        (await Future.wait(_dataSet.map((BookData e) => e.relativeFilePath)))
            .toSet();
    final Set<String> selectedCollections = collectionList
        .where((CollectionData e) => e.pathList
            .map((String e) => basename(e))
            .toSet()
            .intersection(pathSet.toSet())
            .isNotEmpty)
        .map((CollectionData e) => e.id)
        .toSet();

    collectionList.sort(
        (CollectionData a, CollectionData b) => compareNatural(a.name, b.name));

    emit(CollectionAddBookState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
      bookPathSet: pathSet,
    ));
  }

  Future<void> select(String id) async {
    final List<CollectionData> newList =
        List<CollectionData>.from(state.collectionList);
    final CollectionData target =
        newList.firstWhere((CollectionData e) => e.id == id);
    final Set<String> set = target.pathList.toSet();
    set.addAll(state.bookPathSet);
    target.pathList = set.toList();
    emit(state.copyWith(
      collectionList: newList,
      selectedCollections: <String>{...state.selectedCollections, id},
    ));
  }

  void deselect(String id) {
    emit(state.copyWith(
        selectedCollections: <String>{...state.selectedCollections}
          ..remove(id)));
  }

  Future<void> save() async {
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data.id)) {
        data.pathList.addAll(state.bookPathSet);
      } else {
        data.pathList.removeWhere((String e) => state.bookPathSet.contains(e));
      }
      CollectionService.repository.save(data);
    }
  }
}
