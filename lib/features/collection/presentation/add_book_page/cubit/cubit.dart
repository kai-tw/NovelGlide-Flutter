part of '../collection_add_book_scaffold.dart';

class _Cubit extends Cubit<_State> {
  factory _Cubit(Set<BookData> dataSet) {
    final _Cubit cubit = _Cubit._internal(
      dataSet,
      const _State(),
    );
    cubit._init();
    return cubit;
  }

  _Cubit._internal(this.dataSet, super.initialState);

  final Set<BookData> dataSet;

  Set<String> get pathSet =>
      dataSet.map((BookData e) => e.relativeFilePath).toSet();

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  Future<void> refresh() async {
    final List<CollectionData> collectionList =
        await CollectionService.repository.getList();
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

    emit(_State(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
    ));
  }

  void select(String id) {
    final List<CollectionData> newList =
        List<CollectionData>.from(state.collectionList);
    final CollectionData target =
        newList.firstWhere((CollectionData e) => e.id == id);
    final Set<String> set = target.pathList.toSet();
    set.addAll(pathSet);
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

  void save() {
    final Set<String> pathList =
        dataSet.map((BookData e) => e.relativeFilePath).toSet();
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data.id)) {
        data.pathList.addAll(pathList);
      } else {
        data.pathList.removeWhere((String e) => pathList.contains(e));
      }
      CollectionService.repository.save(data);
    }
  }
}

class _State extends Equatable {
  const _State({
    this.code = LoadingStateCode.initial,
    this.collectionList = const <CollectionData>[],
    this.selectedCollections = const <String>{},
  });

  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<String> selectedCollections;

  @override
  List<Object?> get props =>
      <Object?>[code, collectionList, selectedCollections];

  _State copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    Set<String>? selectedCollections,
  }) {
    return _State(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
    );
  }
}
