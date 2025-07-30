part of '../../../collection_service.dart';

class CollectionAddBookCubit extends Cubit<CollectionAddBookState> {
  factory CollectionAddBookCubit(Set<BookData> dataSet) {
    final CollectionAddBookCubit cubit = CollectionAddBookCubit._(dataSet);

    // Refresh at first.
    cubit.refresh();

    // Listen to collection changes.
    cubit._onChangedSubscription = CollectionService
        .repository.onChangedController.stream
        .listen((_) => cubit.refresh());
    return cubit;
  }

  CollectionAddBookCubit._(this._dataSet)
      : super(const CollectionAddBookState());

  final Set<BookData> _dataSet;
  late final StreamSubscription<void> _onChangedSubscription;

  Future<void> refresh() async {
    // Get the collection list from repository.
    final List<CollectionData> collectionList =
        await CollectionService.repository.getList();

    // Get all the book paths from user selected books.
    final Set<String> relativePathSet =
        (await Future.wait(_dataSet.map((BookData e) => e.relativeFilePath)))
            .toSet();

    // Get the selected collection set by
    // intersection of book paths and collection paths.
    final Set<CollectionData> selectedCollections = collectionList
        .where((CollectionData e) =>
            e.pathList.toSet().intersection(relativePathSet).isNotEmpty)
        .toSet();

    // Sort the collection list by name.
    collectionList.sort(
        (CollectionData a, CollectionData b) => compareNatural(a.name, b.name));

    emit(CollectionAddBookState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
      bookRelativePathSet: relativePathSet,
    ));
  }

  Future<void> select(CollectionData data) async {
    data.pathList.addAll(state.bookRelativePathSet);
    emit(state.copyWith(
      selectedCollections: <CollectionData>{...state.selectedCollections, data},
    ));
  }

  void deselect(CollectionData data) {
    data.pathList
        .removeWhere((String e) => state.bookRelativePathSet.contains(e));
    emit(state.copyWith(
        selectedCollections: <CollectionData>{...state.selectedCollections}
          ..remove(data)));
  }

  Future<void> save() {
    return CollectionService.repository
        .updateData(state.collectionList.toSet());
  }

  @override
  Future<void> close() {
    _onChangedSubscription.cancel();
    return super.close();
  }
}
