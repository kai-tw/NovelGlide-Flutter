part of '../../../collection_service.dart';

class CollectionAddBookCubit extends Cubit<CollectionAddBookState> {
  CollectionAddBookCubit(
    this._getCollectionListUseCase,
    this._observeCollectionChangeUseCase,
    this._updateCollectionDataUseCase,
  ) : super(const CollectionAddBookState());

  late final Set<Book> _dataSet;
  late final StreamSubscription<void> _onChangedSubscription;

  final GetCollectionListUseCase _getCollectionListUseCase;
  final ObserveCollectionChangeUseCase _observeCollectionChangeUseCase;
  final UpdateCollectionDataUseCase _updateCollectionDataUseCase;

  /// Get data from widget.
  Future<void> init(Set<Book> dataSet) async {
    _dataSet = dataSet;

    // Refresh at first.
    refresh();

    // Listen to collection changes.
    _onChangedSubscription =
        _observeCollectionChangeUseCase().listen((_) => refresh());
  }

  Future<void> refresh() async {
    if (state.code.isLoading || state.code.isBackgroundLoading) {
      return;
    }

    // Get the collection list from repository.
    final List<CollectionData> collectionList =
        await _getCollectionListUseCase();

    // Get all the identifiers from user selected books.
    final Set<String> relativePathSet =
        _dataSet.map((Book e) => e.identifier).toSet();

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
    return _updateCollectionDataUseCase(state.collectionList.toSet());
  }

  @override
  Future<void> close() {
    _onChangedSubscription.cancel();
    return super.close();
  }
}
