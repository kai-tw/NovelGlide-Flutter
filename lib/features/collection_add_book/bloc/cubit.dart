part of '../collection_add_book_scaffold.dart';

class _Cubit extends Cubit<_State> {
  final Set<BookData> dataSet;

  Set<String> get pathSet => dataSet.map((e) => e.relativeFilePath).toSet();

  factory _Cubit(Set<BookData> dataSet) {
    final cubit = _Cubit._internal(
      dataSet,
      const _State(),
    );
    cubit._init();
    return cubit;
  }

  _Cubit._internal(this.dataSet, super.initialState);

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() {
    List<CollectionData> collectionList = CollectionRepository.getList();
    Set<String> selectedCollections = collectionList
        .where((e) => e.pathList
            .map((e) => basename(e))
            .toSet()
            .intersection(pathSet.toSet())
            .isNotEmpty)
        .map((e) => e.id)
        .toSet();

    collectionList.sort((a, b) => compareNatural(a.name, b.name));

    emit(_State(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
    ));
  }

  void select(String id) {
    final newList = List<CollectionData>.from(state.collectionList);
    final target = newList.firstWhere((e) => e.id == id);
    final set = target.pathList.toSet();
    set.addAll(pathSet);
    target.pathList = set.toList();
    emit(state.copyWith(
      collectionList: newList,
      selectedCollections: {...state.selectedCollections, id},
    ));
  }

  void deselect(String id) {
    emit(state.copyWith(
        selectedCollections: {...state.selectedCollections}..remove(id)));
  }

  void save() {
    final pathList = dataSet.map((e) => e.relativeFilePath).toSet();
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data.id)) {
        data.pathList.addAll(pathList);
      } else {
        data.pathList.removeWhere((e) => pathList.contains(e));
      }
      CollectionRepository.save(data);
    }
  }
}

class _State extends Equatable {
  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<String> selectedCollections;

  @override
  List<Object?> get props => [code, collectionList, selectedCollections];

  const _State({
    this.code = LoadingStateCode.initial,
    this.collectionList = const [],
    this.selectedCollections = const {},
  });

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
