import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/collection_data.dart';
import '../../../enum/loading_state_code.dart';

class CollectionViewerCubit extends Cubit<CollectionViewerState> {
  CollectionData collectionData;

  CollectionViewerCubit(this.collectionData)
      : super(const CollectionViewerState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() async {
    collectionData = CollectionData.fromId(collectionData.id);
    List<BookData> bookList = [];

    for (String path in collectionData.pathList) {
      if (state.bookList.where((e) => e.filePath == path).isNotEmpty) {
        // Already in the list, so copy it.
        bookList.add(state.bookList.firstWhere((e) => e.filePath == path));
      } else {
        // Doesn't exist in the list, so load it.
        bookList.add(
            BookData.fromEpubBook(path, await BookData.loadEpubBook(path)));
      }
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
    collectionData.save();
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
