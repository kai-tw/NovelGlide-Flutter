part of '../table_of_contents.dart';

class _CollectionCubit extends Cubit<_CollectionState> {
  final BookData bookData;

  factory _CollectionCubit(BookData bookData) {
    final cubit = _CollectionCubit._internal(
      bookData,
      const _CollectionState(),
    );
    cubit._init();
    return cubit;
  }

  _CollectionCubit._internal(this.bookData, super.initialState);

  void _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() {
    List<CollectionData> collectionList = CollectionRepository.getList();
    Set<String> selectedCollections = collectionList
        .where((e) => e.pathList.contains(bookData.filePath))
        .map((e) => e.id)
        .toSet();

    collectionList.sort((a, b) => compareNatural(a.name, b.name));

    emit(_CollectionState(
      code: LoadingStateCode.loaded,
      collectionList: collectionList,
      selectedCollections: selectedCollections,
    ));
  }

  void select(String id) {
    emit(state
        .copyWith(selectedCollections: {...state.selectedCollections, id}));
  }

  void deselect(String id) {
    emit(state.copyWith(
        selectedCollections: {...state.selectedCollections}..remove(id)));
  }

  void save() {
    for (CollectionData data in state.collectionList) {
      if (state.selectedCollections.contains(data.id)) {
        data.pathList.add(bookData.filePath);
      } else if (data.pathList.contains(bookData.filePath)) {
        data.pathList.remove(bookData.filePath);
      }
      CollectionRepository.save(data);
    }
  }
}

class _CollectionState extends Equatable {
  final LoadingStateCode code;
  final List<CollectionData> collectionList;
  final Set<String> selectedCollections;

  @override
  List<Object?> get props => [code, collectionList, selectedCollections];

  const _CollectionState({
    this.code = LoadingStateCode.initial,
    this.collectionList = const [],
    this.selectedCollections = const {},
  });

  _CollectionState copyWith({
    LoadingStateCode? code,
    List<CollectionData>? collectionList,
    Set<String>? selectedCollections,
  }) {
    return _CollectionState(
      code: code ?? this.code,
      collectionList: collectionList ?? this.collectionList,
      selectedCollections: selectedCollections ?? this.selectedCollections,
    );
  }
}
