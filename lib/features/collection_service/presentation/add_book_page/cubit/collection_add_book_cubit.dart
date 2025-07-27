part of '../../../collection_service.dart';

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
    // Get the collection list from repository.
    final List<CollectionData> collectionList =
        await CollectionService.repository.getList();

    // Get all the book paths from user selected books.
    final Set<String> pathSet =
        (await Future.wait(_dataSet.map((BookData e) => e.relativeFilePath)))
            .toSet();

    // Get the selected collection set by
    // intersection of book paths and collection paths.
    final Set<CollectionData> selectedCollections = collectionList
        .where((CollectionData e) => e.pathList
            .map((String e) => basename(e))
            .toSet()
            .intersection(pathSet.toSet())
            .isNotEmpty)
        .toSet();

    // Sort the collection list by name.
    collectionList.sort(
        (CollectionData a, CollectionData b) => compareNatural(a.name, b.name));

    emit(CollectionAddBookState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
      bookPathSet: pathSet,
    ));
  }

  Future<void> select(CollectionData data) async {
    emit(state.copyWith(
      selectedCollections: <CollectionData>{...state.selectedCollections, data},
    ));
  }

  void deselect(CollectionData data) {
    emit(state.copyWith(
        selectedCollections: <CollectionData>{...state.selectedCollections}
          ..remove(data)));
  }

  Future<void> save() async {
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data)) {
        data.pathList.addAll(state.bookPathSet);
      } else {
        data.pathList.removeWhere((String e) => state.bookPathSet.contains(e));
      }
      CollectionService.repository.save(data);
    }
  }
}
