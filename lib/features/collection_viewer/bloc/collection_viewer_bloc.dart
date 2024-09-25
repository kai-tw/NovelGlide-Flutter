import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/book_data.dart';
import '../../../data/collection_data.dart';
import '../../../data/loading_state_code.dart';

class CollectionViewerCubit extends Cubit<CollectionViewerState> {
  CollectionData collectionData;

  CollectionViewerCubit(this.collectionData) : super(const CollectionViewerState());

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refresh();
    });
  }

  void refresh() async {
    collectionData = await CollectionData.fromId(collectionData.id);
    List<BookData> bookList = [];

    for (String path in collectionData.pathList) {
      bookList.add(BookData.fromEpubBook(path, await BookData.loadEpubBook(path)));
    }

    emit(CollectionViewerState(
      code: LoadingStateCode.loaded,
      bookList: [
        ...{...bookList}
      ],
    ));
  }

  void reorder(int oldIndex, int newIndex) {
    collectionData.pathList.insert(newIndex, collectionData.pathList[oldIndex]);
    collectionData.pathList.removeAt(oldIndex);
    collectionData.save();
    refresh();
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
