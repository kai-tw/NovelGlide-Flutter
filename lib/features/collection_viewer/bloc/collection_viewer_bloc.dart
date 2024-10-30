import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_model/book_data.dart';
import '../../../data_model/collection_data.dart';
import '../../../enum/loading_state_code.dart';
import '../../../repository/collection_repository.dart';
import '../../../utils/epub_utils.dart';

class CollectionViewerCubit extends Cubit<CollectionViewerState> {
  CollectionData collectionData;

  factory CollectionViewerCubit(CollectionData collectionData) {
    final cubit = CollectionViewerCubit._internal(
      collectionData,
      const CollectionViewerState(),
    );
    cubit.refresh();
    return cubit;
  }

  CollectionViewerCubit._internal(this.collectionData, super.initialState);

  void refresh() async {
    collectionData = CollectionRepository.get(collectionData.id);
    List<BookData> bookList = [];

    for (String path in collectionData.pathList.toSet()) {
      final target =
          state.bookList.firstWhereOrNull((e) => e.filePath == path) ??
              BookData.fromEpubBook(path, await EpubUtils.loadEpubBook(path));
      bookList.add(target);
    }

    emit(CollectionViewerState(
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
    emit(CollectionViewerState(
      code: LoadingStateCode.loaded,
      bookList: state.bookList,
    ));

    collectionData.pathList =
        state.bookList.map<String>((e) => e.filePath).toList();
    CollectionRepository.save(collectionData);
  }
}

class CollectionViewerState extends Equatable {
  final LoadingStateCode code;
  final List<BookData> bookList;

  @override
  List<Object?> get props => [code, bookList];

  const CollectionViewerState({
    this.code = LoadingStateCode.initial,
    this.bookList = const [],
  });

  CollectionViewerState copyWith({
    LoadingStateCode? code,
    List<BookData>? bookList,
  }) {
    return CollectionViewerState(
      code: code ?? this.code,
      bookList: bookList ?? this.bookList,
    );
  }
}
