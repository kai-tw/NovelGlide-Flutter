part of '../collection_viewer.dart';

class _Cubit extends Cubit<_State> {
  CollectionData collectionData;

  factory _Cubit(CollectionData collectionData) {
    final cubit = _Cubit._internal(collectionData, const _State());
    cubit.refresh();
    return cubit;
  }

  _Cubit._internal(this.collectionData, super.initialState);

  void refresh() async {
    collectionData = CollectionRepository.get(collectionData.id);
    List<BookData> bookList = [];

    for (final path in collectionData.pathList.toSet()) {
      final absolutePath = absolute(FilePath.libraryRoot, path);
      final target =
          state.bookList.firstWhereOrNull((e) => e.filePath == absolutePath) ??
              BookData.fromEpubBook(
                  absolutePath, await EpubUtils.loadEpubBook(absolutePath));
      bookList.add(target);
    }

    emit(_State(
      code: LoadingStateCode.loaded,
      bookList: bookList,
    ));
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex == newIndex) {
      return;
    }

    BookData target = state.bookList.removeAt(oldIndex);
    state.bookList
        .insert(oldIndex < newIndex ? newIndex - 1 : newIndex, target);
    emit(_State(
      code: LoadingStateCode.loaded,
      bookList: state.bookList,
    ));

    collectionData.pathList =
        state.bookList.map<String>((e) => e.filePath).toList();
    CollectionRepository.save(collectionData);
  }
}

class _State extends Equatable {
  final LoadingStateCode code;
  final List<BookData> bookList;

  @override
  List<Object?> get props => [code, bookList];

  const _State({
    this.code = LoadingStateCode.initial,
    this.bookList = const [],
  });

  _State copyWith({
    LoadingStateCode? code,
    List<BookData>? bookList,
  }) {
    return _State(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
    );
  }
}
